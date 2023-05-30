import boto3
from SafePrint import printJSON, getValue

class EC2_Controller:
    def __init__(self):
        self.client = boto3.client("ec2")

    # 해당 EC2에 존재하는 모든 인스턴스를 가져온다
    # Input  : N/A
    # Output :
    #  - 인스턴스 ID (InstanceId)
    #  - 인스턴스 Type (InstanceType)
    #  - State (Monitoring/State)
    #  - 이미지 ID (ImageId)
    #  - 설치된 OS (Platform or Device Log 통해서 가져옴)
    #  - Tags (Tags/[])
    def getAllInstances(self):
        allInstances = {}
        instances = (self.client.describe_instances(Filters=[]))["Reservations"]
        for instance in instances:
            for item in instance["Instances"]:
                if item["InstanceId"] not in allInstances:
                    if "Platform" not in item:
                        item["Platform"] = "Linux"
                    allInstances[item["InstanceId"]] = {
                        "InstanceType": getValue("InstanceType", item),
                        "State": getValue("State", getValue("Monitoring", item)),
                        "ImageId": getValue("ImageId", item),
                        "Platform": getValue("Platform", item),
                        "Tags": getValue("Tags", item)
                    }
        return allInstances
