package org.compiere.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

/**
 * @author rlemeill
 * @author Michael Judd BF [ 2736817 ] - remove deprecated BASE64Encoder classes
 *
 */
public class DigestOfFile
{
    /**
     * @param algorithm ie MD5
     * @throws Exception
     */
    public DigestOfFile(String algorithm) throws Exception
    {
       digestAgent = MessageDigest.getInstance(algorithm);
    }

    /**
     * @param file to hash
     * @return hash
     * @throws Exception
     */
    synchronized public byte[] digestAsByteArray(File file) throws Exception
    {
        digestAgent.reset();
        try (InputStream is = new BufferedInputStream(new FileInputStream(file));
        	 DigestInputStream dis = new DigestInputStream(is, digestAgent))
        {
	        while(dis.read() != -1){}
	        byte[] digest = digestAgent.digest();
	        return digest;
        }                
    }

    public synchronized byte[] digestAsByteArray(byte[] input) throws Exception
    {
    	digestAgent.reset();
        byte[] digest = digestAgent.digest(input);
        return digest;
    }

    /**
     * @author rlemeill
     * @param file
     * @return hash (base64 encoded)
     * @throws Exception
     */
    synchronized public String digestAsBase64(File file) throws Exception
    {
        byte[] digest = digestAsByteArray(file);
        Base64 encoder = new Base64();
        String digestAsBase64 = new String(encoder.encode(digest),"ASCII");
        return digestAsBase64;
    }

    /**
     * @param input
     * @return hash (base64 encoded)
     * @throws Exception
     */
    public synchronized String digestAsBase64(byte[] input) throws Exception
    {
    	byte[] digest = digestAsByteArray(input);
    	Base64 encoder = new Base64();
    	String digestAsBase64 = new String(encoder.encode(digest),"ASCII");
        return digestAsBase64;
    }

    /**
     * 
     * @param file
     * @return hex encoded md5 string
     * @throws Exception
     */
    public synchronized String digestAsHex(File file) throws Exception
    {
        byte[] digest = digestAsByteArray(file);
        return Hex.encodeHexString(digest);
    }

    /**
     * 
     * @param input
     * @return hex encoded md5 string
     * @throws Exception
     */
    public synchronized String digestAsHex(byte[] input) throws Exception
    {
    	byte[] digest = digestAsByteArray(input);
    	return Hex.encodeHexString(digest);
    }
    
    private MessageDigest digestAgent;

    /**
     * @author rlemeill
     * @param args file
     */
    public static void main(String[] args)
    {
        try
        {
            DigestOfFile md5DigestAgent = new DigestOfFile("MD5");

            for (int argIndex = 0; argIndex < args.length; argIndex++)
            {
                {
                    String base64Digest = md5DigestAgent.digestAsBase64(new File(args[argIndex]));
                    System.out.println("Base64 MD5 of " + args[argIndex] + " = [" + base64Digest + "]");
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace(System.out);
        }
    }


    /**
     * @param file1 first file to compare
     * @param file2 second file to compare
     * @return true if files are identic false otherwise
     */
    public static boolean md5HashCompare(File file1,File file2)
    {
    	//compute Hash of existing and downloaded
    	String hashFile1;
    	String hashFile2;
    	try{
    		DigestOfFile md5DigestAgent = new DigestOfFile("MD5");
    		hashFile1 = md5DigestAgent.digestAsHex(file1);
    		hashFile2 = md5DigestAgent.digestAsHex(file2);
    		return hashFile1.equals(hashFile2) ; }
    	catch (Exception e)
		{
    		return false;			//if there is an error during comparison return files are difs
		}
    }

    /**
     * @param file
     * @return md5 hash null if file is not found or other error
     */
    public static String getMD5Hash(File file)
    {
    	String hash;
    	try
    	{
    		DigestOfFile md5DigestAgent = new DigestOfFile("MD5");
    		hash = md5DigestAgent.digestAsHex(file);
    		return hash; 
    	}
    	catch (Exception e)
		{
    		return null;			//if there is an error during comparison return files are difs
		}
    }

    /**
     * Get md5 hash from byte[]
     * @param input
     * @return mdg hash string
     */
    public static String getMD5Hash(byte[] input)
    {
    	String hash;
    	try
    	{
    		DigestOfFile md5DigestAgent = new DigestOfFile("MD5");
    		hash = md5DigestAgent.digestAsHex(input);
    		return hash; 
    	}
    	catch (Exception e)
		{
    		return null;			//if there is an error during comparison return files are difs
		}
    }
}
