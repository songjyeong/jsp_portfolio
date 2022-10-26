<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

.divfooter {
	float : left;
	padding:20px;
	
}

</style>

<div >
	<div class="divfooter">
		<ul>
			<li>CUSTOMER CENTER</li>
			<li>1577-3607</li>
			<li>WEEKDAY : AM 10:00 - PM 06:00</li>
			<li>LUNCH : PM 12:30 - PM 01:30</li>
			<li>CLOSED : SAT, SUN AND HOLIDAYS</li>
			<li><a href="abc@itwill.xyz">E-mail : abc@itwill.xyz</a></li>
			<li>RETURN ADDRESS : 서울특별시 강남구 테헤란로 124길 4층</li>
			<li style="font-size: 11px;">BANK INFO : 기업 123-123456-12-123
				(주)YUM</li>
			<li style="font-size: 11px;">※현재 위 계좌는 사이트 예제를 위한 계좌이므로 저희와 전혀 관련
				없습니다※</li>
		</ul>
	</div>
	
	<div class="divfooter">
		<ul>
			<li><a href="">YUM</a></li>
			<li><a href="">상점</a></li>
			<li><a href="">이야기</a></li>
		</ul>
	</div>
	
	<div class="divfooter">
		<ul>
			<li>주식회사 아이티월_JAVA_129기</li>
			<li>송지영</li>
			<li>123-123456-12-123</li>
			<li>2022-ㅁㅁㅁㅁ-XXXXX <a href="#none"
				onclick="window.open('http://www.ftc.go.kr/bizCommPop.do?wrkr_no=3758100863', 'bizCommPop', 'width=750, height=950;');return false;">
					[사업자정보확인] </a>
			</li>
			<li>06234 서울특별시 강남구 테헤란로 124길 4층</li>
		</ul>
		<ul>
			<li>
				<div class="family_site" >
					<select id="family_site_select">
						<option>FAMILY SITE 바로가기</option>
						<option value="https://wanteat.co.kr/">참고 사이트(먹을 사람)</option>
						<option value="">SEMI_PROJECT_1조</option>
						<option value="">SEMI_PROJECT_2조</option>
						<option value="">SEMI_PROJECT_3조</option>
						<option value="">SEMI_PROJECT_4조</option>
						<option value="">SEMI_PROJECT_5조</option>
						<option value="http://pmy.co.kr/">PMY STUDIO</option>
					</select>
				</div>
			</li>
		</ul>
	<script>
	
	$(document).ready( function() {
	 
	 $("#family_site_select").change( function() {
	 
	 	location.href = $("#family_site_select").val();
	 
	 });
	 
	});
	 
	 </script>
	</div>
	
	<div>
		<ul>
			<li><a href="/index.html"> <img src=""> <%-- 로고 --%></a></li>
			<li><a href="https://www.instagram.com/" target="_blank"></a></li>
			<!--왼쪽 소스에서 a href="여기에 변경될 링크주소를 기입해주세요"-->
			<li><a href="http://pf.kakao.com/" target="_blank"></a></li>
			<!--왼쪽 소스에서 a href="여기에 변경될 링크주소를 기입해주세요"-->
	
			<li>© 먹을사람. All rights reserved.</li>
	
		</ul>
	</div>
</div>

