package com.acn.utils;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/27/14:19
 */
@Component("dateConvert")
public class DateConvert implements Converter<String, Date> {
    @Override
    public Date convert(String string) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = simpleDateFormat.parse(string);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        return date;
    }
}
