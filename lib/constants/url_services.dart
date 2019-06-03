class UrlServices{
  static final bool isDev = true;
  
  static final String auth = isDev 
    ? "https://ws2.sii.cl:9091/APPWSCOREAUTENTICA01CERT/coreautentica01service" 
    : "https://ws1.sii.cl/WSMOBILE/coreautentica01service";
  
  static final String coreRiac = isDev 
    ? "https://ws2.sii.cl:9490/MOBILECERT/coreRiacservice" 
    : "https://ws1.sii.cl/WSMOBILE/coreRiacservice";
    
}