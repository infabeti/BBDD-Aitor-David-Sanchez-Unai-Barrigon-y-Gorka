package bbdd;

import org.apache.commons.dbcp2.BasicDataSource;

public class DataSourceService {
	private BasicDataSource basicDataSource=null;
    private final String USER = "root";
    private final String PASS = "elorrieta";
    private final String URL = "jdbc:mysql://localhost:33060/";

    public DataSourceService(){
         if (null==basicDataSource){
             basicDataSource = new BasicDataSource();
             basicDataSource.setDriverClassName("com.mysql.jdbc.Driver");
             basicDataSource.setUsername(USER); 
             basicDataSource.setPassword(PASS);
             basicDataSource.setUrl(URL);
             basicDataSource.setMinIdle(50);
             basicDataSource.setMaxIdle(100);
         }
     }

     public BasicDataSource getDataSource(){
         return basicDataSource;
     }

}
