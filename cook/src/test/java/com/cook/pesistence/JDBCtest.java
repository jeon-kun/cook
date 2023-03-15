package com.cook.pesistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCtest {
	
	   static { 
	        try { 
	            Class.forName("oracle.jdbc.driver.OracleDriver"); 
	        } catch(Exception e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	    
	    @Test 
	    public void testConnection() { 
	        try(Connection con = DriverManager.getConnection( 
	                "jdbc:log4jdbc:oracle:thin:@localhost:1521:XE", 
	                "cook", 
	                "1234")){ 
	            System.out.println(con); 
	        } catch (Exception e) { 
	            fail(e.getMessage()); 
	        } 
	    
	    }    

}
