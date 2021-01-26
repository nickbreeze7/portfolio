package com.breezenick.whatappclone2021.login;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.breezenick.whatappclone2021.MainActivity;
import com.breezenick.whatappclone2021.MessageActivity;
import com.breezenick.whatappclone2021.R;
import com.breezenick.whatappclone2021.common.Util;
import com.breezenick.whatappclone2021.password.ResetPasswordActivity;
import com.breezenick.whatappclone2021.signup.SignUpActivity;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;

public class LoginActivity extends AppCompatActivity {

    private TextInputEditText etEmail, etPassword;
    private String email , password;
    private View progressBar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        etEmail     = findViewById(R.id.etEmail);
        etPassword  = findViewById(R.id.etPassword);
        progressBar = findViewById(R.id.progressBar3);

    }

    public void tvSignUpClick(View v){
        startActivity(new Intent(this, SignUpActivity.class));
    }


    public void btnLoginClick(View v){
        email     = etEmail.getText().toString().trim();
        password  = etPassword.getText().toString().trim();

        if(email.equals("")){
            etEmail.setError(getString(R.string.enter_email));
        }else if(password.equals("")){
            etPassword.setError(getString(R.string.enter_password));
        }else {
            if(Util.connectionAvailable(this)) {
                progressBar.setVisibility(View.VISIBLE);
                FirebaseAuth firebaseAuth = FirebaseAuth.getInstance();
                firebaseAuth.signInWithEmailAndPassword(email, password).addOnCompleteListener(
                        new OnCompleteListener<AuthResult>() {
                            @Override
                            public void onComplete(@NonNull Task<AuthResult> task) {
                                progressBar.setVisibility(View.GONE);
                                if (task.isSuccessful()) {
                                    startActivity(new Intent(LoginActivity.this, com.breezenick.whatappclone2021.MainActivity.class));
                                    finish();
                                } else {
                                    Toast.makeText(LoginActivity.this,
                                            "Login Failed:" + task.getException(), Toast.LENGTH_SHORT).show();
                                }
                            }
                        }
                );
            }else{
                startActivity(new Intent(LoginActivity.this, com.breezenick.whatappclone2021.MessageActivity.class));
            }
        }
    }
    public void tvResetPasswordClick(View view ){
        startActivity(new Intent(LoginActivity.this, ResetPasswordActivity.class));
    }

    @Override
    protected void onStart() {
        super.onStart();

        FirebaseAuth firebaseAuth = FirebaseAuth.getInstance();
        FirebaseUser firebaseUser = firebaseAuth.getCurrentUser();

        if(firebaseUser!=null){
            FirebaseInstanceId.getInstance().getInstanceId().addOnSuccessListener(new OnSuccessListener<InstanceIdResult>() {
                @Override
                public void onSuccess(InstanceIdResult instanceIdResult) {
                    Util.updateDeviceToken(LoginActivity.this ,
                            instanceIdResult.getToken());
                }
            });
            startActivity(new Intent(LoginActivity.this, com.breezenick.whatappclone2021.MainActivity.class));
            finish();
        }
    }
}