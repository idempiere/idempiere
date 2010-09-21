package org.compiere.interfaces;

/**
 * Interface for adempiere/Status.
 */
public interface Status
{
   /**
    * Get Version (Date)
    * @return version e.g. 2002-09-02    */
   public String getDateVersion(  );

   /**
    * Get Main Version
    * @return main version - e.g. Version 2.4.3b    */
   public String getMainVersion(  );

   /**
    * Get Database Type
    * @return Database Type    */
   public String getDbType(  );

   /**
    * Get Database Host
    * @return Database Host Name    */
   public String getDbHost(  );

   /**
    * Get Database Port
    * @return Database Port    */
   public int getDbPort(  );

   /**
    * Get Database SID
    * @return Database SID    */
   public String getDbName(  );

   /**
    * Get Database URL
    * @return Database URL    */
   public String getConnectionURL(  );

   /**
    * Get Database UID
    * @return Database User Name    */
   public String getDbUid(  );

   /**
    * Get Database PWD
    * @return Database User Password    */
   public String getDbPwd(  );

   /**
    * Get Connection Manager Host
    * @return Connection Manager Host    */
   public String getFwHost(  );

   /**
    * Get Connection Manager Port
    * @return Connection Manager Port    */
   public int getFwPort(  );
}
