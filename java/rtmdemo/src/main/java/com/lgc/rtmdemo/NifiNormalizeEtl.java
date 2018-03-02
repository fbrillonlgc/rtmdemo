package com.lgc.rtmdemo;

import java.io.InputStream;
import java.io.OutputStream;

public interface NifiNormalizeEtl {
  public void normalize( InputStream in, OutputStream out ) throws Exception;
}
