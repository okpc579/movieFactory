package com.icia.moviefactory.service;
 
import java.io.*;
// import java.util.ArrayList;
// import java.util.List;
import java.net.*;

import org.springframework.stereotype.*;
import org.xmlpull.v1.*;

import com.icia.moviefactory.entity.*;

@Service
public class NMovieService {
    private static String clientID = "ACbmK_oruPik0lqZPQyo"; //api 사용 신청시 제공되는 아이디
    private static String clientSecret = "egkBTJGsM5"; //패스워드
    
    public NMovie searchNMovie(String keyword, int display, int start, String pubDate) {
        URL url;
        NMovie list = null;
        try {
            url = new URL("https://openapi.naver.com/v1/search/movie.xml?query=" + URLEncoder.encode(keyword, "UTF-8")	// book에서 movie로 바꿈
                    + (display != 0 ? "&display=" + display : "") + (start != 0 ? "&start=" + start : "") + (pubDate != null ? "&yearfrom=" + pubDate : "")+ (pubDate != null ? "&yearto=" + pubDate : ""));
            
            System.out.println(url);
            URLConnection urlConn;
            
 
            //url 연결
            urlConn = url.openConnection();
            urlConn.setRequestProperty("X-naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-naver-Client-Secret", clientSecret);
 
            //파싱 - 팩토리 만들고 팩토리로 파서 생성 (풀 파서 사용)
            XmlPullParserFactory factory; 
 
            factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput((new InputStreamReader(urlConn.getInputStream())));
 
            
            int eventType = parser.getEventType();
            NMovie b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    //list = new ArrayList<NMovie>();
                    break;
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new NMovie();
                        break;
                    case "image":
                        if (b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "subtitle":
                        if (b != null)
                            b.setSubtitle(parser.nextText());
                        break;
                    case "pubDate":
                        if (b != null)
                            b.setPubDate(parser.nextText());
                        break;
                    }
                    break;
                }
 
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if (tag.equals("item")) {
                        //list.add(b);
                    	if(b==null)
                    		b= new NMovie();
                    	return b;
                        //b = null;
                    }
 
                }
 
                }
                eventType = parser.next();
            }
 
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }
}