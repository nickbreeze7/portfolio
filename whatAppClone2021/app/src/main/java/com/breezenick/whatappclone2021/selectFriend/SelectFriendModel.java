package com.breezenick.whatappclone2021.selectFriend;



public  class SelectFriendModel {
    private String userId;
    private String UserName;
    private String photoName;

    public SelectFriendModel(String userId, String userName, String photoName) {
        this.userId = userId;
        UserName = userName;
        this.photoName = photoName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }
}
