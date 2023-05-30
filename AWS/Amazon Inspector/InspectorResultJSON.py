import boto3
from EC2_test import EC2_Controller

class Inspector_Controller:
    def __init__(self,assessmentRunArns):
        self.client = boto3.client("inspector")
        self.assessmentRunArns = assessmentRunArns
        self.instances = EC2_Controller().getAllInstances()

    # Inspector를 통해 실행된 진단 결과 요약 정보를 불러옴
    # Input  :
    # Output : Dict
    #  - findingArns
    def getListFindings(self):
        listFindings = {}
        for assessmentRunArn in self.assessmentRunArns:
            listFinding = []
            target = self.client.list_findings(assessmentRunArns=[assessmentRunArn])
            while True:
                listFinding = listFinding + target['findingArns']
                if "nextToken" not in target: break
                target = self.client.list_findings(assessmentRunArns=[assessmentRunArn], nextToken=target["nextToken"])
            listFindings[assessmentRunArn] = listFinding
        return listFindings

    # Inspector를 통해 실행된 진단 결과 상세 정보를 불러옴
    # Input  :
    # Output : Dict
    #  - arn
    #  - id
    #  - assetAttributes/agentId
    #  - confidence
    #  - description
    #  - indicatorOfCompromise
    #  - recommendation
    #  - serviceAttributes/rulesPackageArn
    #  - severity
    #  - title
    #  - OSversion
    def getDetailFindings(self):
        listFindings = self.getListFindings()
        findingDetails = {}
        for k in listFindings:
            findingDetails[k] = {}
            for i in range(0, int(len(listFindings[k])/100)+1):
                details = self.client.describe_findings(findingArns=listFindings[k][i*100:(i+1)*100], locale="EN_US")["findings"]
                for d in details:
                    findingDetails[k][d["arn"]] = {
                        "id": d["id"],
                        "agentId": d["assetAttributes"]["agentId"],
                        "confidence": d["confidence"],
                        "description": ' '.join(d["description"].replace("Description\n\n","").split()),
                        "indicatorOfComproimse": d["indicatorOfCompromise"],
                        "recommendation": ' '.join(d["recommendation"].split()),
                        "rulesPackageArn": d["serviceAttributes"]["rulesPackageArn"],
                        "serverity": d["severity"],
                        "title": ' '.join(d["title"].split()),
                        "accountID": k.split(":")[4],
                        "region": k.split(":")[3]
                    }
                    tags = d["assetAttributes"]["tags"]
                    for instance,v in self.instances.items():
                        if instance == d["assetAttributes"]["agentId"]:
                            for tag in v["Tags"]:
                                if tag['Key'] == 'OSversion':
                                    temp = {"OSversion": tag['Value']}
                                    findingDetails[k][d["arn"]].update(temp)
                                if tag['Key'] == 'ServiceName':
                                    temp = {"ServiceName": tag['Value']}
                                    findingDetails[k][d["arn"]].update(temp)
                                if tag['Key'] == 'ManagerName':
                                    temp = {"ManagerName": tag['Value']}
                                    findingDetails[k][d["arn"]].update(temp)
                    netInt = d["assetAttributes"]["networkInterfaces"]
                    for n in netInt:
                        temp = {"vpcID": n['vpcId']}
                        findingDetails[k][d["arn"]].update(temp)
        return findingDetails
