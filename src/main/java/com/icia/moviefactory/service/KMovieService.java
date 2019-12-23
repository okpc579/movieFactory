package com.icia.moviefactory.service;

import java.io.*;
import java.net.*;
import java.util.*;

import org.springframework.stereotype.*;
import org.xmlpull.v1.*;

import com.icia.moviefactory.entity.*;

@Service
public class KMovieService {
	public List<KMovie> searchKMovie(String keyword, int curpage) {
        URL url;
        List<KMovie> list = null;
        String typeNm = null;
        boolean isContinue = true;
        try {
            url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.xml?key=147d96f90a50a05230287f0f02412bfd&movieNm=" + URLEncoder.encode(keyword, "UTF-8")
                    + (curpage != 0 ? "&curPage=" + curpage : "") + "&movieTypeCd=220101");
            URLConnection urlConn;
            
            
            //url 연결
            urlConn = url.openConnection();
 
            //파싱 - 팩토리 만들고 팩토리로 파서 생성 (풀 파서 사용)
            XmlPullParserFactory factory; 
 
            factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput((new InputStreamReader(urlConn.getInputStream())));
            
            int eventType = parser.getEventType();
            KMovie b = null;
            
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<KMovie>();
                    break;
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "totCnt":
                        b = new KMovie();
                        b.setTotCnt(parser.nextText());
                        list.add(b);
                        break;
                    case "movie":
                        b = new KMovie();
                        break;
                    case "movieCd":
                        if (b != null)
                            b.setMovieCd(parser.nextText());
                        break;
                    case "movieNm":
                        if (b != null)
                            b.setMovieNm(parser.nextText());
                        break;
                    case "movieNmEn":
                        if (b != null)
                            b.setMovieNmEn(parser.nextText());
                        break;
                    case "prdtYear":
                        if (b != null)
                            b.setPrdtYear(parser.nextText());
                        break;
                    case "repNationNm":
                        if (b != null)
                            b.setRepNationNm(parser.nextText());
                        break;
                    case "peopleNm":
                        if (b != null)
                            b.setDirectors(parser.nextText());
                        break;
                    case "repGenreNm":
                        if (b != null)
                            b.setRepGenreNm(parser.nextText());
                        break;
                    
                    }
                    break;
                }
 
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if (tag.equals("movie")) {
                        list.add(b);
                        b = null;
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
	
	
	
	
	
	
	public KMovieRead searchKMovieRead(String keyword) {	//디테일 리드
        URL url;
        //List<KMovie> list = null;
        KMovieRead b = null;
        try {
            url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + URLEncoder.encode(keyword, "UTF-8"));
            URLConnection urlConn;
            
            
            //url 연결
            urlConn = url.openConnection();
 
            //파싱 - 팩토리 만들고 팩토리로 파서 생성 (풀 파서 사용)
            XmlPullParserFactory factory; 
 
            factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput((new InputStreamReader(urlConn.getInputStream())));
            
            int eventType = parser.getEventType();
            
            List<String> genres = new ArrayList<String>();
            List<String> actors = new ArrayList<String>();
            List<String> cast = new ArrayList<String>();
            boolean isActors = false;
            
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    //list = new ArrayList<KMovie>();
                    break;
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "movieInfo":
                        b = new KMovieRead();
                        break;
                    case "movieCd":
                        if (b != null)
                            b.setMovieCd(parser.nextText());
                        break;
                    case "movieNm":
                        if (b != null)
                            b.setMovieNm(parser.nextText());
                        break;
                    case "movieNmEn":
                        if (b != null)
                            b.setMovieNmEn(parser.nextText());
                        break;
                    case "showTm":
                        if (b != null)
                            b.setShowTm(parser.nextText());
                        break;
                    case "prdtYear":
                        if (b != null)
                            b.setPrdtYear(parser.nextText());
                        break;
                    case "openDt":
                        if (b != null)
                            b.setOpenDt(parser.nextText());
                        break;
                    case "nationNm":
                        if (b != null)
                            b.setNationNm(parser.nextText());
                        break;
                    case "genreNm":
                        if (b != null)
                            genres.add(parser.nextText());
                        break;
                    case "actors":
                        isActors=true;
                        break;
                    case "peopleNm":
                    	if(isActors==false) {
                    		if (b != null)
                                b.setDirectors(parser.nextText());
                            break;
                    	}else {
                    		if (b != null)
                                actors.add(parser.nextText());
                            break;
                    	}
                    case "watchGradeNm":
                        if (b != null)
                        	b.setWatchGradeNm(parser.nextText());
                        break;
                    case "cast":
                        if (isActors==true)
                            cast.add(parser.nextText());
                        break;
                    }
                    
                    break;
                }
 
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if (tag.equals("movieInfo")) {
                        //list.add(b);
                        //b = null;
                    	b.setActors(actors);
                    	b.setCast(cast);
                    	b.setGenres(genres);
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
        //return list;
        return b;
	}
	
	
	//
	
	/*
	public KMovieRead searchKMovieGenre(String keyword) {	//디테일 리드
        URL url;
        KMovieRead b = null;
        try {
            url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&genreNm=" + URLEncoder.encode(keyword, "UTF-8"));
            URLConnection urlConn;
            
            
            //url 연결
            urlConn = url.openConnection();
 
            //파싱 - 팩토리 만들고 팩토리로 파서 생성 (풀 파서 사용)
            XmlPullParserFactory factory; 
 
            factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput((new InputStreamReader(urlConn.getInputStream())));
            
            int eventType = parser.getEventType();
            
            List<String> genres = new ArrayList<String>();
            // List<String> actors = new ArrayList<String>();
            // List<String> cast = new ArrayList<String>();
            // boolean isActors = false;
            
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    //list = new ArrayList<KMovie>();
                    break;
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "movieInfo":
                        b = new KMovieRead();
                        break;
                    case "movieCd":
                        if (b != null)
                            b.setMovieCd(parser.nextText());
                        break;
                    case "movieNm":
                        if (b != null)
                            b.setMovieNm(parser.nextText());
                        break;
                    case "movieNmEn":
                        if (b != null)
                            b.setMovieNmEn(parser.nextText());
                        break;
                    case "prdtYear":
                        if (b != null)
                            b.setPrdtYear(parser.nextText());
                        break;
                    case "openDt":
                        if (b != null)
                            b.setOpenDt(parser.nextText());
                        break;
                    case "nationNm":
                        if (b != null)
                            b.setNationNm(parser.nextText());
                        break;
                    case "genreNm":
                        if (b != null)
                            genres.add(parser.nextText());
                        break;
                    case "watchGradeNm":
                        if (b != null)
                        	b.setWatchGradeNm(parser.nextText());
                        break;
                    }
                    
                    break;
                }
 
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if (tag.equals("movieInfo")) {
                        //list.add(b);
                        //b = null;
                    	b.setGenres(genres);
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
        //return list;
        return b;
	}
	*/
}
