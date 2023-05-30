AMI 진단 자동화 스크립트 기능
세부 설명
1) main.py (코드 목적: 이 파일만 실행하면 됨)

       	> 본 파일 안에 하단의 세부 모듈들이 전부 포함되어 있음.
 
 
 
2) EC2_test.py (코드 목적: 인스턴스의 tag값을 읽어오기 위함)
 
 
 
3) InspectorResultJSON.py (코드 목적: Inspector 결과Arn값으로부터 취약항목의 세부내용을 JSON 형태로 저장하기 위함)
 
 
 
4) FinalReport.py (코드 목적: JSON 형태의 결과값을 Excel 결과파일로 파싱/생성함)
 
         4.1. InitExcel.py (코드 목적: Excel 결과파일의 템플릿 형태로 생성하기 위함)
         
         
         
         4.2. ResultFilter.py (코드 목적: 하단의 5가지 요소를 필터링 하기 위함)
              
              --> 위험도 재조정
              
              --> 확인필요 항목 필터링 : 해당 항목은 로컬환경에서 실행할 경우 print함수를 이용하여 로그로 출력되고, Lambda로 실행할 경우 CloudWatch Log 영역에 출력됩니다. 해당 로그 출력값을 보고 해당하는 확인필요 항목을 추가로 점검하시면 됩니다.
              
              --> 신규/운영중인 서비스 구분하여 개발자 입장에서 주의해야 할 점 코멘트 추가.

              --> 예외처리 필터링 : 과도한 항목들은 리포팅 하지 않음. 그외 개발자가 예외처리 요청하는 항목들은 필터링용 데이터셋 파일(csv) 업데이트 해야 함.

              --> 보안대책 필터링 : 기존 inspector 보안대책으로는 부족한 부분을 보강한 보안대책으로 변경함.
 
 
 
5) Jira_Issue.py (코드 목적: JIRA티켓 생성하기 위함)
	
  > 메인티켓: 서비스 당 하나씩
	
  > 서브티켓: 인스턴스 당 하나씩(첨부파일로 결과엑셀파일이 첨부됨)