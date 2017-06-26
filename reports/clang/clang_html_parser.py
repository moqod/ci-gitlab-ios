from pyquery import PyQuery
from BeautifulSoup import BeautifulSoup, Comment
import json
import os
import time
import sys

reportsFolder = '.'

def dict_from_html(htmlPath):
    json_dict = {
        'report': 'reports/' + htmlPath
    }

    mapping = {'BUGDESC': 'desc',
                'BUGTYPE': 'type',
                'BUGCATEGORY': 'category',
                'FILENAME': 'filename',
                'FUNCTIONNAME': 'function',
                'BUGLINE': 'line',
                'BUGCOLUMN': 'column',
                'BUGFILE': 'path'}

    # load html into string
    with open(htmlPath, 'r') as content_file:
        content = content_file.read()

    # parse html
    soup = BeautifulSoup(content)
    comments = soup.findAll(text = lambda text: isinstance(text, Comment))

    # grab needed comments
    for c in comments:
        # analyze interesting stuff
        stripped = c.strip()

        for key in mapping.keys():
            if key in stripped:
                # line[len(prefix):]
                json_dict[mapping[key]] = stripped[(len(key)+1):]
                del mapping[key]

    return json_dict;

def list_from_htmls(folderPath):
    # key is path
    # value is violation
    result_dict = {}
    files = filter(lambda path: path.endswith('.html'), os.listdir(folderPath))

    for f in files:
        if "Pods/" not in f # super check for Pods :)
            jd = dict_from_html(f)
            # result_list.append(jd)
            path = jd['path']
            if result_dict.has_key(path):
                existing_array = result_dict[path]
                existing_array.append(jd)
            else:
                result_dict[jd['path']] = [jd]

    # now generate final list
    result_list = []
    for k in result_dict.keys():
        d = {}

        d['path'] = k
        d['violations'] = result_dict[k]

        # just remove path from violations
        for v in d['violations']:
            del v['path']

        result_list.append(d)

    return result_list;

def report_for_folder(folderPath):
    result = {}
    summary = {}

    violations = list_from_htmls(folderPath)
    summary['files_count'] = len(violations)

    violations_count = 0
    for f in violations:
        for v in f['violations']:
            violations_count += 1
    summary['violations_count'] = violations_count
    summary['time'] = time.time()

    result['summary'] = summary
    result['files'] = violations

    return result;

# magic starts here...

# params
# first - html reports folder
# second - project name
if len(sys.argv) > 1:
    reportsFolder = sys.argv[1]

os.chdir(reportsFolder)
result = report_for_folder(reportsFolder)
print json.dumps(result)
