package com.icia.moviefactory.service;

import java.io.*;
import java.net.*;

import org.springframework.stereotype.*;

@Service
public class CaptchaService {
	 public String captchaKey() {
	     String clientId = "5K8mkLpbsNQQI3fjhSss";//애플리케이션 클라이언트 아이디값";
	     String clientSecret = "NNJbBjeuCW";//애플리케이션 클라이언트 시크릿값";
	     try {
	         String code = "0"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
	         String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
	         URL url = new URL(apiURL);
	         HttpURLConnection con = (HttpURLConnection)url.openConnection();
	         con.setRequestMethod("GET");
	         con.setRequestProperty("X-Naver-Client-Id", clientId);
	         con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	         int responseCode = con.getResponseCode();
	         BufferedReader br;
	         if(responseCode==200) { // 정상 호출
	             br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	         } else {  // 에러 발생
	             br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	         }
	         String inputLine;
	         StringBuffer response = new StringBuffer();
	         while ((inputLine = br.readLine()) != null) {
	             response.append(inputLine);
	         }
	         br.close();
	         System.out.println(response.toString());
	         
	         return response.toString();
	         
	     } catch (Exception e) {
	         System.out.println(e);
	     }
		return "";
	 }
	 
	 
	  public String captchaImage(String keys, String values) {
	        String clientId = "5K8mkLpbsNQQI3fjhSss";//애플리케이션 클라이언트 아이디값";
	        String clientSecret = "NNJbBjeuCW";//애플리케이션 클라이언트 시크릿값";
	        try {
	            String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
	            String key = keys; // 캡차 키 발급시 받은 키값
	            String value = values; // 사용자가 입력한 캡차 이미지 글자값
	            System.out.println(key + value);
	            String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;

	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { // 정상 호출
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            } else {  // 에러 발생
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                response.append(inputLine);
	            }
	            br.close();
	            System.out.println(response.toString());
	            return response.toString();
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        System.out.println("내려갔음");
	        return "";
	    }
}
