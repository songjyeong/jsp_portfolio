package xyz.itwill.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import java.util.regex.Pattern;

public class Utility {

	// 1. 문자열을 전달받아 암호화 처리하여 반환하는 메서드
	public static String encrypt(String source) {
		// 암호화된 문자열을 저장하기 위한 변수 선언
		String password="";
		
		try {
			MessageDigest messageDigest=MessageDigest.getInstance("SHA-256");
			messageDigest.update(source.getBytes());
			byte[] digest=messageDigest.digest();
			for(int i=0;i<digest.length;i++) {
				password+= Integer.toHexString(digest[i]&0xff);
			}
			
		} catch (NoSuchAlgorithmException  e) {
			System.out.println("[에러] 잘못된 암호화 알고리즘을 사용 하였습니다.");
		}
		return password;
	}
	
	// 2. 문자열을 전달받아 태그 관련 문자열을 모두 제거하여 반환하는 메서드
	public static String stripTag(String source) {
		Pattern htmlTag=Pattern.compile("\\<.*?\\>");
		source=htmlTag.matcher(source).replaceAll("");
		return source;
	}
	
	// 3. 문자열을 전달받아 태그 관련 기호를 회피문자로 변환하여 반환하는 메서드
	public static String escapeTag(String source) {
		return source.replace("<", "&lt;").replace(">", "&gt;");
	}
	
	// 4. 임시 비밀번호를 생성하여 반환하는 메서드
	public static String newPassword() {
		Random random=new Random();
		
		String str="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		
		String password="";
		for(int i=1;i<=8;i++) {
			password+=str.charAt(random.nextInt(str.length()));
		}
			
		return password;
	}
	
	
	
}
