#! /usr/local/bin/python3
import json
import sys
import pickle
import os
import time

def loadReport(fileJSON):
    print ("fileJSON " + os.getcwd()+fileJSON)

    try:
        with open(os.getcwd()+fileJSON) as data_file:
            data = json.load(data_file)
            print("FILE GOOD")
            return data
    # except EnvironmentError:
    except IOError:
        print("BAD FILE")
        return {}

def getTestsReport(reports):
    result = []
    i = 0
    while i < len(reports):
        report = loadReport(data["reports"][i]["report_json"])
        if len(report) == 0:
            i += 1
            continue
        test_report = {"type": data["reports"][i]["type"],
                "report": data["reports"][i]["report_html"]}
        test_report.update(report[data["reports"][i]["summary"]])
        result.append(test_report)
        i += 1
    return result

data = json.loads(sys.argv[1])
summary_report = {"summary" : {"project" : data["project_name"],
                "branch" : data["branch"],
                "commit" : data["commit_hash"],
                "bundle_version" : data["bundle_version"],
                "time" : time.time()},
                "reports" : getTestsReport(data["reports"])
                }
with open(os.getcwd() + "/reports/json/summary.json", 'w') as outfile:
    json.dump(summary_report, outfile)