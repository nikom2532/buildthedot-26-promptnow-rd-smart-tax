/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.VulcanCore;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.Security;
import javax.crypto.Cipher;
import javax.crypto.KeyAgreement;
import javax.crypto.interfaces.DHPublicKey;
import javax.crypto.spec.DHParameterSpec;
import javax.crypto.spec.DHPublicKeySpec;
import javax.crypto.spec.SecretKeySpec;
import org.bouncycastle.crypto.BufferedBlockCipher;
import org.bouncycastle.crypto.CipherParameters;
import org.bouncycastle.crypto.engines.AESEngine;
import org.bouncycastle.crypto.modes.CBCBlockCipher;
import org.bouncycastle.crypto.modes.PaddedBlockCipher;
import org.bouncycastle.crypto.params.KeyParameter;
import org.bouncycastle.crypto.params.ParametersWithIV;
/**
 *
 * @author Promptnow11
 */
public class SecureSecService{

    private String SECURE_SECRET;
    private byte[] SECRET_KEY;
    protected static String[] INITIALIZE = { "THEREISOURSECRET", "VULCANN_PLATFORM", "DON'TTELLANYBODY" ,"VULCAN_SECUREKEY"};


    protected String ENCRYPT_KEY = "";
    protected String DECRYPT_KEY = "";


    // <editor-fold defaultstate="collapsed" desc="Utility Method">
    
    public byte[] toByteArray( String HEX_STRING ){
	if( HEX_STRING.length() % 2 != 0 ) throw new UnsupportedOperationException("'HEX_STRING' is invalid.");
	return new java.math.BigInteger( HEX_STRING, 16 ).toByteArray();
    }

    public String toHexString( byte[] BLOCKS ){
	if( BLOCKS == null ) return "";
	char[] HEX_CHARS = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
	StringBuffer buffer = new StringBuffer();
	for ( byte CURRENT_BLOCK : BLOCKS )
		buffer.append( HEX_CHARS[ (CURRENT_BLOCK & 0xf0) >> 4 ] ).append( HEX_CHARS[ CURRENT_BLOCK & 0x0f ] );
	return buffer.toString();
    }

    private byte[] hexStringToByteArray(String str) {
        int len = str.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(str.charAt(i), 16) << 4) + Character.digit(str.charAt(i + 1), 16));
        }
        return data;
    }
    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Key Exchange">
    public String[] keyExchange(String modulus, String exponent, String identify) throws Exception{
        BigInteger MODULUS = new BigInteger(modulus);
        BigInteger EXPONENT = new BigInteger(exponent);
        BigInteger IDENTIFY = new BigInteger(identify);

        java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        
        DHPublicKey PUBLIC_KEY = (DHPublicKey) KeyFactory.getInstance("DH","BC").generatePublic( new DHPublicKeySpec( IDENTIFY, MODULUS, EXPONENT ) );
        DHParameterSpec DH_PARAM = PUBLIC_KEY.getParams();
        KeyPairGenerator GENERATOR = KeyPairGenerator.getInstance("DH","BC");
        GENERATOR.initialize( DH_PARAM );

        KeyPair KEY_PAIR = GENERATOR.generateKeyPair();
        KeyAgreement AGREEMENT = KeyAgreement.getInstance("DH","BC");
        AGREEMENT.init( KEY_PAIR.getPrivate() );
        AGREEMENT.doPhase( PUBLIC_KEY, true );

        SECRET_KEY = AGREEMENT.generateSecret();

        if( SECRET_KEY == null || SECRET_KEY.length < 1 ) return null;
        byte[] KEY = ((DHPublicKey) KEY_PAIR.getPublic()).getY().toByteArray();
        //System.out.println("PUBLIC KEY: length="+ KEY.length +", HEX="+ toHexString(KEY));

        int LAST_VALUE = 0;
        long CURRENT_TIMEMS = System.currentTimeMillis();
        for( char DIGIT : String.valueOf(CURRENT_TIMEMS).toCharArray() ) LAST_VALUE += Integer.parseInt(String.valueOf(DIGIT));
        SECURE_SECRET = (new BigInteger( String.valueOf(LAST_VALUE) ).toString(16) + toHexString(SECRET_KEY) +"FF").toUpperCase();

        String[] data = new String[4];
        data[0] = new BigInteger( KEY ).toString(10);
        data[1] = String.valueOf(CURRENT_TIMEMS);
        data[2] = INITIALIZE[1];
        data[3] = SECURE_SECRET;

        VulcanCore.log.debug("Identify : "+new BigInteger( KEY ).toString(10));
        VulcanCore.log.debug("Timestamp : "+String.valueOf(CURRENT_TIMEMS));
        VulcanCore.log.debug("Independent : "+INITIALIZE[1]);
        VulcanCore.log.debug("SECURE_SECRET :" +SECURE_SECRET);

        return data;
    }


    public void setSecretKey(String secretKey){
        SECURE_SECRET = secretKey;
        SECRET_KEY = toByteArray(SECURE_SECRET);
        //System.out.println("" + SECRET_KEY.length);
        //VulcanCore.log.debug("" + SECRET_KEY.length);
        
        byte[] TEMP;
	byte[] TEMP2;
        // Key 256 bits
        TEMP = new byte[32];
        TEMP2 = new byte[32];
        for(int i=0;i<=31;i++){
            TEMP[i] = SECRET_KEY[(2*i+1) +1];
            TEMP2[i] = SECRET_KEY[(62-2*i) +1];
        }
        //System.out.println("Encrypt : "+ toHexString(TEMP));
        //System.out.println("Decrypt : " + toHexString(TEMP2));
        
        VulcanCore.log.debug("Encrypt : "+ toHexString(TEMP));
        VulcanCore.log.debug("Decrypt : " + toHexString(TEMP2));

        ENCRYPT_KEY = toHexString(TEMP);
        DECRYPT_KEY = toHexString(TEMP2);
    }

    public String getSecretKey(){
        return SECURE_SECRET;
    }
    
    public String getDECRYPT_KEY() {
        return DECRYPT_KEY;
    }

    public String getENCRYPT_KEY() {
        return ENCRYPT_KEY;
    }

    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Encrypt Decrypt Method">


    // Encryption AES/ECB/PKCS7Padding
    public byte[] encryptAES(byte[] input, byte[] keyBytes) throws Exception{
        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        SecretKeySpec key = new SecretKeySpec(keyBytes, "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS7Padding", "BC");
        cipher.init(Cipher.ENCRYPT_MODE, key);
	byte[] cipherText = new byte[cipher.getOutputSize(input.length)];
	int ctLength = cipher.update(input, 0, input.length, cipherText, 0);
	ctLength += cipher.doFinal(cipherText, ctLength);
        return cipherText;
    }

    // Decryption AES/ECB/PKCS7Padding
    public byte[] decryptAES(byte[] input, byte[] keyBytes) throws Exception{
        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        SecretKeySpec key = new SecretKeySpec(keyBytes, "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS7Padding", "BC");
        cipher.init(Cipher.DECRYPT_MODE, key);
	byte[] plainText = new byte[cipher.getOutputSize(input.length)];
	int ptLength = cipher.update(input, 0, input.length, plainText, 0);
	ptLength += cipher.doFinal(plainText, ptLength);
        return plainText;
    }








    
    public byte[] decrypt(byte[] data) throws Exception{
        return decrypt(data,hexStringToByteArray(ENCRYPT_KEY));
    }

    public byte[] encrypt(byte[] data) throws Exception{
        return encrypt(data,hexStringToByteArray(DECRYPT_KEY));
    }

    public byte[] encrypt( byte[] data ,byte[] key)throws Exception {
    	BufferedBlockCipher cipher = new PaddedBlockCipher(new CBCBlockCipher(new AESEngine()));
    	if( data == null || data.length == 0 ){
            return new byte[0];
        }
        CipherParameters param  = new KeyParameter(key) ;
        ParametersWithIV paIV = new ParametersWithIV(param,INITIALIZE[1].getBytes());
        cipher.init( true, paIV );
        return callCipher( data ,cipher);
    }

    public byte[] decrypt( byte[] data,byte[] key )throws Exception {
    	BufferedBlockCipher cipher = new PaddedBlockCipher(new CBCBlockCipher(new AESEngine()));
        if( data == null || data.length == 0 ){
            return new byte[0];
        }
        CipherParameters param  = new KeyParameter(key) ;
        ParametersWithIV paIV = new ParametersWithIV(param,INITIALIZE[1].getBytes());
        cipher.init( false, paIV );
        return callCipher( data ,cipher);
    }

    public byte[] encrypt( byte[] data ,byte[] key ,byte[] iv)throws Exception {
    	BufferedBlockCipher cipher = new PaddedBlockCipher(new CBCBlockCipher(new AESEngine()));
    	if( data == null || data.length == 0 ){
            return new byte[0];
        }
        CipherParameters param  = new KeyParameter(key) ;
        ParametersWithIV paIV = new ParametersWithIV(param, iv);
        cipher.init( true, paIV );
        return callCipher( data ,cipher);
    }

    public byte[] decrypt( byte[] data,byte[] key ,byte[] iv)throws Exception {
    	BufferedBlockCipher cipher = new PaddedBlockCipher(new CBCBlockCipher(new AESEngine()));
    	if( data == null || data.length == 0 ){
            return new byte[0];
        }
        CipherParameters param  = new KeyParameter(key) ;
        ParametersWithIV paIV = new ParametersWithIV(param, iv);
        cipher.init( false, paIV );
        return callCipher( data ,cipher);
    }

    private byte[] callCipher( byte[] data , BufferedBlockCipher cipher)throws Exception {
        int    size = cipher.getOutputSize( data.length );
        byte[] result = new byte[ size ];
        int    olen = cipher.processBytes( data, 0, data.length, result, 0 );
        olen += cipher.doFinal( result, olen );
        if( olen < size ){
            byte[] tmp = new byte[ olen ];
            System.arraycopy(result, 0, tmp, 0, olen );
            result = tmp;
        }
        return result;
    }

    // </editor-fold>

}
