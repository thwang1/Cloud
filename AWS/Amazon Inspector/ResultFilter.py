from InspectorResultJSON import Inspector_Controller
import csv

class Filter_Controller:
    def __init__(self,osversion):
        # 데이터셋 파일을 os별로 만들것
        # S3에 업로드되는 csv파일명과 여기에 하드코딩 되는 파일명이 반드시 일치해야함
        # ec2 인스턴스의 태그값과 여기에 하드코딩되는 OS 버전명이 반드시 일치해야함
        if osversion == "Amazon Linux 1":
            self.f = open('ResultFilter_Dataset_Amazon1.csv', 'r', encoding='euc-kr')
        if osversion == "Amazon Linux 2":
            self.f = open('ResultFilter_Dataset_Amazon2.csv', 'r', encoding='euc-kr')
        if osversion == "CentOS 7":
            self.f = open('ResultFilter_Dataset_CentOS7.csv', 'r', encoding='euc-kr')
        self.rdr = csv.reader(self.f)

    # 확인필요 항목과 결과항목을 비교함
    # 확인필요인 경우 true return
    # 확인필요 아닌 경우 false return
    # Input: os (string)
    #        category (string)
    #        titleNum (string)
    # Output: Boolean(true, false)
    def AdditionalCheck(self,os,category,titleNum):
        for line in self.rdr:
            if(line[0] == titleNum and line[1] == os and line[2] == category):
                if(line[6] == "O"):
                    self.f.close()
                    return True
        self.f.close()
        return False

    # 각 항목마다 위험도 조정함
    # 매칭되는 항목이 있을 경우 위험도 return
    # 매칭되는 항목이 없을 경우 None return
    # Input: os (string)
    #        category (string)
    #        titleNum (string)
    # Output: String (High,Medium,Low,Informational)
    def SeverityCheck(self,os,category,titleNum):
        for line in self.rdr:
            if(line[0] == titleNum and line[1] == os and line[2] == category):
                self.f.close()
                return line[9]
        self.f.close()
        return None

    # 신규/운영중인 서비스는 각각 조치사항에 대한 comment를 추가함
    # 매칭되는 항목이 있을 경우 comment arrary return
    # 매칭되는 항목이 없을 경우 None return
    # Input: os (string)
    #        category (string)
    #        titleNum (string)
    # Output: Array_String (신규/운영별로 추가comment)
    def NewOrCurrentCheck(self,os,category,titleNum):
        arr = [None] * 2
        for line in self.rdr:
            if(line[0] == titleNum and line[1] == os and line[2] == category):
                arr[0] = line[14]
                arr[1] = line[15]
                break
        self.f.close()
        return arr

    # 예외처리 항목은 제외가 필요함
    # 예외처리인 경우 true return
    # 예외처리 아닌 경우 false return
    # Input: os (string)
    #        category (string)
    #        titleNum (string)
    # Output: Boolean(true, false)
    def NotApplicableCheck(self,os,category,titleNum):
        for line in self.rdr:
            if(line[0] == titleNum and line[1] == os and line[2] == category):
                if(line[4] == "O"):
                    self.f.close()
                    return True
        self.f.close()
        return False

    # 개발자가 실제 적용 가능한 보안대책으로 변경 필요함
    # ex. 시스템 재부팅 필요여부
    # 매칭되는 항목이 있을 경우 보안대책 return
    # 매칭되는 항목이 없을 경우 None return
    # Input: os (string)
    #        category (string)
    #        titleNum (string)
    # Output: String (High,Medium,Low,Informational)
    def RemediationCheck(self,os,category,titleNum):
        for line in self.rdr:
            if(line[0] == titleNum and line[1] == os and line[2] == category):
                self.f.close()
                return line[12]
        self.f.close()
        return None
