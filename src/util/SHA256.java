package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA256 {

    public static String getSHA256(String input) { //이메일 값에 해시를 적용한 값을 반환해서 적용
        StringBuffer result = new StringBuffer();
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] salt = "Hello! Ths is Salt.".getBytes(); //악의적인 공격자로부터 안전성 업
            digest.reset();
            digest.update(salt);
            byte[] chars = digest.digest(input.getBytes("UTF-8"));
            for (int i = 0; i < chars.length; i++) {
                String hex = Integer.toHexString(0xff & chars[i]);
                if (hex.length() == 1)
                    result.append("0");
                result.append(hex);
            }
        } catch (NoSuchAlgorithmException e) {
            System.err.println("SHA256 Exception error");
        } catch (UnsupportedEncodingException e) {
            System.err.println("SHA256 Exception error");
        }
        return result.toString();
    }
}
