package user;

public class UserDTO {

    private String userID;
    private String userPassword;
    private String userName;
    private String userEmail;
    private String userEmailHash;
    private String userIP1;
    private String userIP2;
    private String userIP3;
    private String userIP4;

    private boolean userEmailChecked;

    public UserDTO() {

    }

    public UserDTO(String userID, String userPassword, String userName, String userEmail,
                   String userEmailHash, boolean userEmailChecked, String userIP1, String userIP2, String userIP3, String userIP4) {
        super();
        this.userID = userID;
        this.userPassword = userPassword;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userEmailHash = userEmailHash;
        this.userEmailChecked = userEmailChecked;
        this.userIP1 = userIP1;
        this.userIP2 = userIP2;
        this.userIP3 = userIP3;
        this.userIP4 = userIP4;

    }

    public String getUserEmailHash() {
        return userEmailHash;
    }

    public void setUserEmailHash(String userEmailHash) { this.userEmailHash = userEmailHash;
    }


    public boolean isUserEmailChecked() {
        return userEmailChecked;
    }

    public void setUserEmailChecked(boolean userEmailChecked) {
        this.userEmailChecked = userEmailChecked;
    }


    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }


    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserIP1() {
        return userIP1;
    }

    public void setUserIP1(String userIP1) {
        this.userIP1 = userIP1;
    }

    public String getUserIP2() {
        return userIP2;
    }

    public void setUserIP2(String userIP2) {
        this.userIP2 = userIP2;
    }

    public String getUserIP3() {
        return userIP3;
    }

    public void setUserIP3(String userIP3) {
        this.userIP3 = userIP3;
    }

    public String getUserIP4() {
        return userIP4;
    }

    public void setUserIP4(String userIP4) {
        this.userIP4 = userIP4;
    }

}