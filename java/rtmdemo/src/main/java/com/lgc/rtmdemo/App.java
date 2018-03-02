package com.lgc.rtmdemo;

import com.lgc.rtmdemo.NifiNormalizeEtl;

public class App
{
    public static void main( String[] args ) throws Exception {
       String etlName = "com.lgc.rtmdemo." + args[0];
       NifiNormalizeEtl etl = (NifiNormalizeEtl) Class.forName(etlName).newInstance();
       etl.normalize( System.in, System.out );
    }
}
