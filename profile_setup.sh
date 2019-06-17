#!/bin/bash

sudo apt update

# install basic editor packages
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

sudo apt-get install vim-gui-common
sudo apt-get install vim-runtime

source install_opencv.sh
#!/usr/bin/env python3

# std imports
import argparse
import os
import re
import json


class PlantUmlSDWriter():

    def __init__(self, call_tree_json):
        self.call_tree_json = call_tree_json
        self.uml_list = []

    def print_call_tree(self):
        print(json.dumps(self.call_tree_json, indent=4, sort_keys=True))

    def __get_participant_list(self, caller_json):
            for caller in caller_json:
                if len(caller) > 1:
                    for call_arg in caller_json[caller]["arg_list"]:
                        print("balh")
                        # print ("\t\t\t\t" + call_arg)
    def __draw_participants(self, caller_json, cmd_json=None):
        if cmd_json is None:
            cmd_list = []
            for caller in caller_json:
                if len(caller) > 1:
                    for call_arg in caller_json[caller]['arg_list']:
                        if call_arg not in cmd_list:
                            print( "call arg: " + call_arg)
                            cmd_list.append(call_arg)
                            call_str = "participant " + call_arg
                            uml_list.append(call_str)
        else:
            for cmd_type in cmd_json:
                participant_str = "participant " + cmd_type
                self.uml_list.append(participant_str)

    def __draw_calls(self, caller_json, cmd_json=None):
        if cmd_json is None:
            cmd_list = []
            for caller in caller_json:
                if len(caller) > 1:
                    for call_arg in caller_json[caller]['arg_list']:
                        if call_arg not in cmd_list:
                            cmd_list.append(call_arg)
                            call_str = "maintCmd-->" + call_arg  + " : " + caller
                            self.uml_list.append(call_str)
        else:
            for caller in caller_json:
                for call_arg in caller_json[caller]['arg_list']:
                    has_cmd_type = False
                    # self.uml_list.append("activate module_FrameWork")
                    for cmd_type in cmd_json:
                        if call_arg in cmd_json[cmd_type]:
                            has_cmd_type = True
                            self.uml_list.append("maintCmd-->" + cmd_type + " : " \
                                + caller + " - " + call_arg)
                    if has_cmd_type == False:
                            self.uml_list.append("maintCmd-->Unknown_Cmd_Type : " + caller)
                    # self.uml_list.append("deactivate module_FrameWork")

    def draw(self, mod_struct=None):
        file_name = self.call_tree_json['base_func_str'] + "_SD.puml"
        caller_json = self.call_tree_json['callers']
        # participant_list = self.__get_participant_list(caller_json)
        cmd_list = []


        self.uml_list.append("@startuml alt_" + file_name[:-5] )
        self.uml_list.append("participant maintCmd")
        self.uml_list.append("participant Unknown_Cmd_Type")

        self.__draw_participants(caller_json, mod_struct['cmd_org'])
        self.__draw_calls(caller_json, mod_struct['cmd_org'])

        self.uml_list.append("participant module_FrameWork")
        self.uml_list.append("@enduml")

        with open(file_name, "w") as write_file:
            for line in self.uml_list:
                write_file.write(line + "\n")

class PlantUmlCDWriter():
    def __generate_line_list(self):
        self.line_list.append("@startuml test \n\n")
        for class_name in self.cd_json['classes']:
            line_str = "class " + class_name + "{"
            self.line_list.append(line_str + "\n")
            for attribute in self.cd_json['classes'][class_name]['attributes']:
                line_str = attribute['name']
                self.line_list.append("\t" + line_str + "\n")
            for method in self.cd_json['classes'][class_name]['methods']:
                line_str = method['name'] + "()"
                self.line_list.append("\t" + line_str + "\n")
            self.line_list.append("}\n\n")
        self.line_list.append("@enduml test")

    def __init__(self, cd_json):
        self.cd_json = cd_json
        self.line_list = []
        self.__generate_line_list()

    def draw_cd_uml(self):
        with open(os.getcwd() + "/test.puml", "w") as puml_file:
            for line in self.line_list:
                puml_file.write(line)



class PlantUmlCDReader():

    #TODO Consider moving the class parser into another class
    def __method_search(self, line):
        #TODO Break this up
        capture_group_count = 0
        found_method_arg = False
        method_json = {}
        while True:
            capture_group_str = str(capture_group_count) + "}"
            re_str = self.re_strs['method_arg']  + capture_group_str
            re_res = re.search(re_str,line)
            if re_res:
                if 'name' not in method_json:
                    method_json = \
                        {
                            'name' : re_res.group(2),
                            'type' : re_res.group(1)
                        }
                if re_res.group(4) and re_res.group(5):
                    arg_json = {
                        'name' : re_res.group(5),
                        'type' : re_res.group(4)
                    }
                    if 'args' in method_json:
                        method_json['args'].append(arg_json)
                    else:
                        method_json['args'] = [arg_json]
                else:
                    if found_method_arg:
                        self.cd_json['classes'][self.class_name]['methods'].\
                            append(method_json)
                        break
                    found_method_arg = True
            elif not re.search(self.re_strs['method'], line):
                    break
            capture_group_count = capture_group_count + 1


    def __in_class_search(self, line):
        re_res = re.search(self.re_strs['end_class'], line)
        if re_res:
            return False
        re_res = re.search(self.re_strs['attributes'],line)
        if re_res:
            self.cd_json['classes'][self.class_name]['attributes'].append(
                {
                    'name' : re_res.group(2),
                    'type' : re_res.group(1)
                }
            )
            return True
        # Method search requires an added layer of complexity so its moved
        # into its own function
        self.__method_search(line)
        return True

    def __out_of_class_search(self, line):
                re_res = re.search(self.re_strs['class'], line)
                if re_res:
                    self.class_name = re_res.group(1)
                    class_json = {
                        'attributes' : [],
                        'methods' : []
                    }
                    self.cd_json['classes'][self.class_name] = class_json
                    return True

                re_res = re.search(self.re_strs['inherits_left'], line)
                if re_res:
                    parent_class = re_res.group(2)
                    child_class = re_res.group(1)
                    self.cd_json['classes'][self.class_name]['attributes']
                    return False

    def __parse_file(self, read_file):
        in_class_mode = False
        for iter, line in enumerate(read_file):
            if not in_class_mode:
                in_class_mode = self.__out_of_class_search(line)
            else:
                in_class_mode = self.__in_class_search(line)



    def __init__(self, diagram_path):
        self.diagram_path = diagram_path
        self.cd_json = {'classes' : {}}
        #TODO consider moving all that references this into its own class
        self.class_name = ""

        #TODO Add example strings that each regex cmd would find
        inherits_left_re_str = \
            r"^([a-zA-Z|\d]*)--\|>([a-zA-Z|\d]*)$"
        attribute_re_str = \
            r"^\s{4}([a-z]*)\s([a-z|A-Z|_]*)$"
        init_method_re_str = \
            r"^\s+-init\(((\s?[a-zA-Z_\d]+)\s?:\s?([a-zA-Z_\d]+)((\s?=\s?[a-zA-Z_\d]+)?,?))"
        private_method_re_str = \
            r"\s{4}def\s__([a-zA-Z_]+)\(self,?\s?([a-zA-Z_]+)?\):$"
        public_method_re_str = \
            r"^\s{4}([a-z]*)\s([a-z|A-Z|_]*)\([^)]*\)$"
        method_arg_re_str = \
            r"^\s{4}([a-z]*)\s([a-z|A-Z|_]*)\((\s?([a-z]*)\s?([a-zA-Z_]*)[,\s]?" + "){0,"
        end_class_re_str = \
            r"^}$"
        class_re_str = \
            r"^class\s([A-Z][a-z|A-Z|^{]*)\s{$"
        self.re_strs = {
            'class' : class_re_str,
            'end_class' : end_class_re_str,
            'method_arg' : method_arg_re_str,
            'public_method' : public_method_re_str,
            'private_method' : private_method_re_str,
            'init_method' : init_method_re_str,
            'method_arg' : method_arg_re_str,
            'method' : method_re_str,
            'attributes' : attribute_re_str,
            'inherits_left' : inherits_left_re_str
        }
        # self.read_diagram(diagram_path)

    def read_diagram(self):
        with open(self.diagram_path, "r") as cd_file:
            self.__parse_file(cd_file)

    def print_diagram(self):
        print(json.dumps(self.cd_json, indent=4, sort_keys=True))
