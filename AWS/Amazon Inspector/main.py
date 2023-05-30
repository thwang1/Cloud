from FinalReport import Report_Controller
from InspectorResultJSON import Inspector_Controller
from Jira_Issue import Jira_Reporting

def main():
    # Inspector 실행완료 되면 AWS SNS 알림이 진단자 이메일로 전송됨
    # 전송되는 메시지에 RunArn 부분 확인하여  asRunArns 변수값으로 저장필요함.
    # 진단자 이메일이 아닌 AWS Lambda 함수 호출할 경우 함수 입력값으로 SNS 메시지의 ARN 전달 필요함.
    # asRunArns 데이터 타입 : List -> ["~arn_num"]
    arn = ["arn:aws:inspector:us-east-2:537095765475:target/0-kN7k4DoL/template/0-qTsOHEyq/run/0-8lHvc2k5"] # 입력값 필요
    #arn = ["arn:aws:inspector:ap-northeast-2:997937744622:target/0-llVzgcut/template/0-eDMA0Xj6/run/0-gADATrVD"]

    # Inspector 결과JSON 파싱
    findings = Inspector_Controller(arn).getDetailFindings()

    # 엑셀결과파일 생성(파싱 -> 위험도/확인필요/코멘트추가/예외처리 -> 결과파일 출력)
    report = Report_Controller(findings)
    report.JsonParsing()
    report.changeSeverity() # 위험도 재조정
    addCheck = report.changeAddCheck() # 확인필요 항목 필터링
    for k,v in addCheck.items(): # 확인필요 항목 로그출력(CloudWatch 확인가능)
        print(k, end='')
        print(v)
    report.addNewOrCurrentComment() # 신규/운영중인 서비스 구분하여 추가 코멘트 작성
    report.changeNotApplicable() # 예외처리 필터링
    report.changeRemediation() # 보안대책 필터링
    report.DataIntoExcel()
    numFindings = report.calcNumFindings() # 취약항목 개수 산정
    fileNames = report.submitFileNames() # 결과파일 이름 출력
    parsedFindings = report.returnParsedFindings() # 각 인스턴스 당 파싱된 취약항목 출력

    # 생성한 액셀결과파일을 첨부파일로 하여 jira 티켓 생성
    # 메인티켓 : 각 서비스 당 하나씩
    # 서브티켓 : 각 인스턴스 당 하나씩
    #       - description : 요약본
    #       - 첨부파일 : 결과엑셀파일
    jira = Jira_Reporting(parsedFindings,numFindings,fileNames)
    jira.createJiraTicket()


if __name__ == '__main__':
    main()
