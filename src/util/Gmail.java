package util;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class Gmail extends Authenticator{

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("jikimee64@gmail.com", "hqobonmawjulbpbx");
    }

}