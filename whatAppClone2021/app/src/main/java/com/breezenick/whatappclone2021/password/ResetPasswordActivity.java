package com.breezenick.whatappclone2021.password;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.breezenick.whatappclone2021.R;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.auth.FirebaseAuth;

public class ResetPasswordActivity extends AppCompatActivity {
    private TextInputEditText etEmail;
    private TextView tvMessage;
    private LinearLayout llResetPassword, llMessage;
    private Button btnRetry;
    private View progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reset_password);

        etEmail    = findViewById(R.id.etEmail);
        tvMessage  = findViewById(R.id.tvMessage);
        llMessage  = findViewById(R.id.llMessage);
        llResetPassword = findViewById(R.id.llResetPassword);
        btnRetry   = findViewById(R.id.btnRetry);
        progressBar = findViewById(R.id.progressBar3);

    }

    public void btnResetPasswordClick(View view){
        final String email = etEmail.getText().toString().trim();

        if(email.equals("")){
            etEmail.setError(getString(R.string.enter_email));
        }else{
            progressBar.setVisibility(View.VISIBLE);
            FirebaseAuth firebaseAuth = FirebaseAuth.getInstance();
            firebaseAuth.sendPasswordResetEmail(email).addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    progressBar.setVisibility(View.GONE);
                    llResetPassword.setVisibility(View.GONE);
                    llMessage.setVisibility(View.VISIBLE);

                    if(task.isSuccessful()){
                        tvMessage.setText(getString(R.string.reset_password_instructions, email));
                        new CountDownTimer(60000, 1000){

                            @SuppressLint("SetTextI18n")
                            @Override
                            public void onTick(long l) {
                                btnRetry.setText(getString(R.string.resend_timer ,
                                        String.valueOf(l/1000))        );
                                btnRetry.setOnClickListener(null);
                            }

                            @Override
                            public void onFinish() {
                                btnRetry.setText(R.string.retry);
                                btnRetry.setOnClickListener(new View.OnClickListener(){
                                    @Override
                                    public void onClick(View v) {
                                        llResetPassword.setVisibility(View.VISIBLE);
                                        llMessage.setVisibility(View.GONE);
                                    }
                                });
                            }
                        }.start();
                    }else{
                        tvMessage.setText(getString(R.string.email_sent_failed,
                                task.getException() ));
                        btnRetry.setText(R.string.retry);
                        btnRetry.setOnClickListener(new View.OnClickListener(){
                            @Override
                            public void onClick(View v) {
                                llResetPassword.setVisibility(View.VISIBLE);
                                llMessage.setVisibility(View.GONE);
                            }
                        });
                    }
                }
            });
        }
    }
        public void btnCloseClick(View view ){
            finish();
        }
}