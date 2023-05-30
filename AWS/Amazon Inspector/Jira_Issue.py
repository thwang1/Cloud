from jira import JIRA

class Jira_Reporting:
    def __init__(self,detailFindings,numFindings,fileNames):
        options = {'server': 'http://jira.skplanet.com'}
        # JIRA계정 하드코딩?
        username = 'PP91424'
        password = 'Ns957182'
        self.watchers = 'PP91424' # 수정 가능
        self.reporter = 'PP91424' # 수정 가능

        self.jira = JIRA(options, basic_auth=(username, password))

        self.detailFindings = detailFindings

        for key,value in self.detailFindings.items():
            self.accountid = value['accountID']
            self.vpcid = value['vpcID']
            self.serviceName = value['ServiceName']
            self.managerName = value['ManagerName']
            break

        self.numFindings = numFindings #취약항목 개수
        self.filenames = fileNames #결과엑셀파일명
        self.sumMain = 'AWS점검_' + self.serviceName + '_1분기' #메인티켓이름
        self.descMain = self.serviceName + ' AWS 점검 결과' + '상세 내용은 서브티켓 확인' #메인티켓설명

    def createMainTicket(self):
        main_list = [{
          'project': {'key': 'SECUFINDINGS'},
          'labels': [self.accountid, self.vpcid],
          'assignee': {'name': self.managerName},
          'summary': self.sumMain,
          'priority': {'name': 'Major'},
          'issuetype': {'name': 'Task'},
          'reporter': {'name': self.reporter},
          'description': self.descMain
        }]
        main_issue = self.jira.create_issue(fields=main_list[0])
        self.jira.add_watcher(main_issue, self.watchers)

        return main_issue

    def createSubTicket(self,main):
        for key,value in self.detailFindings.items():
            instanceid = ''
            osversion = ''
            region = ''
            for ke,val in value.items():
                instanceid = key
                osversion = value['OS']
                region = value['region']
                tempOSversion = ""
                for i in osversion.split():
                    tempOSversion = tempOSversion + i
                osversion = tempOSversion
            sumSub = '시스템진단(OS)_Inspector_' + region + '_ec2-instance_' + instanceid
            descSub = '안녕하세요.  EC2 인스턴스의 시스템진단(OS) 점검결과 전달 드립니다.\n'+\
                    '발견된 취약점 개수: ' + str(self.numFindings) + '\n' +\
                    '조치방법\n'+\
                    '- 첨부된 엑셀파일의 "보안대책" 또는 첨부된 가이드 PDF 파일 내 "Remediation" 부분 확인\n'+\
                    '- 조치 시작 시, "조치 시작" 버튼 클릭하여, 티켓 상태를 "조치 중"으로 변경\n' +\
                    '- 조치 완료 시, "이행점검요청" 버튼 클릭하여, 티켓 상태를 "이행점검대기"로 변경\n' +\
                    '안내사항\n' +\
                    '- 조치하려고 하는 서비스가 신규인 경우와 현재 운영중인 서비스로 구분하셔서 첨부된 엑셀파일의 "H열"과 "I열" 확인하시고 조치하시면 됩니다.(*노란색 색칠된 부분)'+\
                    '- EC2에 현재 운영 중인 서비스가 동작 중인 경우, OS 설정 변경 전 "영향도"를 꼭 검토하셔야 합니다.\n'+\
                    '- 영향도 검토 후, 즉시 반영이 어려운 경우 기간을 롱텀으로 잡고 조치하시거나(조치계획 Comment로 전달), 예외처리(예외의견 Comment로 작성) 하시면 됩니다.\n'+\
                    '* 결과 및 가이드는 영문 버전으로 제공합니다.\n'+\
                    '* 궁금하신 사항은 Comment 로 문의해주세요.\n'
            sub_list = [{
              'project': {'key': 'SECUFINDINGS'},
              'parent': {'key': main.key},
              'labels': [osversion],
              'assignee': {'name': self.managerName},
              'summary': sumSub,
              'priority': {'name': 'Major'},
              'issuetype': {'name': 'Sub-task'},
              'reporter': {'name': self.reporter},
              'description': descSub,
              'customfield_20005': '시스템진단 (OS)', #점검유형
              'customfield_20006': 'Inspector', #점검방법
              'customfield_20007': region, #대상위치
              'customfield_20008': 'ec2-instance', #대상유형
              'customfield_20009': instanceid} #대상이름
            ]
            sub_issue = self.jira.create_issue(fields=sub_list[0])
            for fn in self.filenames:
                if instanceid in fn:
                    with open(fn, 'rb') as f:
                        self.jira.add_attachment(issue=sub_issue, attachment=f)
            self.jira.add_watcher(sub_issue, self.watchers)

    def createJiraTicket(self):
        main_issue = self.createMainTicket()
        self.createSubTicket(main_issue)
