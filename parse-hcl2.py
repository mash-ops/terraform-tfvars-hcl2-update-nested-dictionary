#!/usr/local/bin/python3.9
##!/usr/bin/env python3
#Author : Manjesh.Munegowda@sap.com
#Date   : Nov05, 2022
#Purpose: Append dictionary to nested dictionary in hcl2 tfvars file. 
#         1) hcl2 tfvars file as input (hardcoded for poc)
#Usage  : ./parse-hcl2.py

import hcl2, pprint, json
f = open ('tfvars', "r")
  
# Reading from file
data = hcl2.loads(f.read())

mydata= { 'manjeshData': { 'size': 64, 'type': "manjesh", 'lun': 6, 'vg': "VG_SAPARCH02", 'lv': "SAP_ARCH02", 'mount': "/sapdb/<SID>/saparch", 'caching': "ReadWrite" }}
 
print(type(data))
for k,v in list(data.items()):
  #if 'pay_db_disks' in k:
  if 'myProd_db_disks' in k:
      data['myProd_db_disks'].update(mydata)
      print(k, v)
      #print(type(k))
print("\n\n---after updating---\n")
pprint.pprint(data)
with open('hcl.outfile', 'w') as o_write:
  json.dump(data, o_write, indent=2, separators=[",", " = "])
  #o_write.write('{}\n'.format(json.dumps(data)))

# Closing file
f.close()
