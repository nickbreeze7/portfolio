package com.breezenick.whatappclone2021.findfriends;


import android.content.Context;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.breezenick.whatappclone2021.R;
import com.breezenick.whatappclone2021.common.Constants;
import com.breezenick.whatappclone2021.common.NodeNames;
import com.breezenick.whatappclone2021.common.Util;
import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.util.List;

public class FindFriendAdapter extends
            RecyclerView.Adapter<FindFriendAdapter.FindFriendViewHolder> {
    private Context context;
    private List<FindFriendModel> findFriendModelList;

    private  DatabaseReference friendRequestDatabase;
    private FirebaseUser currentUser;
    private String userId;

    public FindFriendAdapter(Context context, List<FindFriendModel> findFriendModelList) {
        this.context = context;
        this.findFriendModelList = findFriendModelList;
    }

    @NonNull
    @Override
    public FindFriendViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
       View view =
               LayoutInflater.from(context).inflate(R.layout.find_friends_layout, parent , false);

        return new FindFriendViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull final FindFriendViewHolder holder, int position) {
        final FindFriendModel friendModel = findFriendModelList.get(position);

        // 얘가 빠지면 이름이 안나옴. 20200704
        holder.tvFullName.setText(friendModel.getUserName());

        StorageReference fileRef =
                FirebaseStorage.getInstance()
                        .getReference()
                        .child(Constants.IMAGES_FOLDER + "/" + friendModel.getPhotoName());

        fileRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(Uri uri) {
                Glide.with(context)
                        .load(uri)
                        .placeholder(R.drawable.default_profile)
                        .error(R.drawable.default_profile)
                        .into(holder.ivProfile);
            }
        });
        friendRequestDatabase = FirebaseDatabase.getInstance().getReference().child(NodeNames.FRIEND_REQUESTS);
        currentUser = FirebaseAuth.getInstance().getCurrentUser();

        if(friendModel.isRequestSent()){
            holder.btnSendRequest.setVisibility(View.GONE);
            holder.btnCancelRequest.setVisibility(View.VISIBLE);
        }else{
            holder.btnSendRequest.setVisibility(View.VISIBLE);
            holder.btnCancelRequest.setVisibility(View.GONE);
        }

        holder.btnSendRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                holder.btnSendRequest.setVisibility(View.GONE);
                holder.pbRequest.setVisibility(View.VISIBLE);

                userId = friendModel.getUserId();

                friendRequestDatabase.child(currentUser.getUid()).child(userId).child(NodeNames.REQUEST_TYPE)
                        .setValue(Constants.REQUEST_STATUS_SENT).addOnCompleteListener(new OnCompleteListener<Void>() {

                    @Override
                    public void onComplete(@NonNull Task<Void> task) {
                            if(task.isSuccessful()){
                                friendRequestDatabase.child(userId).child(currentUser.getUid())
                                        .child(NodeNames.REQUEST_TYPE)
                                        .setValue(Constants.REQUEST_STATUS_RECEIVED)
                                        .addOnCompleteListener(new OnCompleteListener<Void>() {
                                            @Override
                                            public void onComplete(@NonNull Task<Void> task) {
                                                if(task.isSuccessful()){
                                                    Toast.makeText(context,
                                                            R.string.request_sent_successfully,
                                                            Toast.LENGTH_SHORT).show();

                                                    String title ="New Friend Request";
                                                    String message = "Friend request from "+ currentUser.getDisplayName();

                                                    Util.sendNotification(context, title , message , userId);

                                                    holder.btnSendRequest.setVisibility(View.GONE);
                                                    holder.pbRequest.setVisibility(View.GONE);
                                                    holder.btnCancelRequest.setVisibility(View.VISIBLE);

                                                }else{
                                                    Toast.makeText(context,
                                                            context.getString(R.string.failed_to_send_reqeust,
                                                            task.getException()),
                                                            Toast.LENGTH_SHORT).show();
                                                    holder.btnSendRequest.setVisibility(View.VISIBLE);
                                                    holder.pbRequest.setVisibility(View.GONE);
                                                    holder.btnCancelRequest.setVisibility(View.GONE);

                                                }
                                            }
                                        });

                                } else{
                                Toast.makeText(context,
                                        context.getString(R.string.failed_to_send_reqeust,
                                                task.getException()),
                                        Toast.LENGTH_SHORT).show();
                                holder.btnSendRequest.setVisibility(View.VISIBLE);
                                holder.pbRequest.setVisibility(View.GONE);
                                holder.btnCancelRequest.setVisibility(View.GONE);

                            }
                    }
                });
            }
        });

        holder.btnCancelRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                holder.btnCancelRequest.setVisibility(View.VISIBLE);
                holder.pbRequest.setVisibility(View.VISIBLE);

                userId = friendModel.getUserId();

                friendRequestDatabase.child(currentUser.getUid()).child(userId).child(NodeNames.REQUEST_TYPE)
                        .setValue(null).addOnCompleteListener(new OnCompleteListener<Void>() {

                    @Override
                    public void onComplete(@NonNull Task<Void> task) {
                        if(task.isSuccessful()){
                            friendRequestDatabase.child(userId).child(currentUser.getUid())
                                    .child(NodeNames.REQUEST_TYPE)
                                    .setValue(null)
                                    .addOnCompleteListener(new OnCompleteListener<Void>() {
                                        @Override
                                        public void onComplete(@NonNull Task<Void> task) {
                                            if(task.isSuccessful()){
                                                Toast.makeText(context,
                                                        R.string.request_cancelled_successfully,
                                                        Toast.LENGTH_SHORT).show();
                                                holder.btnSendRequest.setVisibility(View.VISIBLE);
                                                holder.pbRequest.setVisibility(View.GONE);
                                                holder.btnCancelRequest.setVisibility(View.GONE);

                                            }else{
                                                Toast.makeText(context,
                                                        context.getString(R.string.failed_to_cancel_reqeust,
                                                                task.getException()),
                                                        Toast.LENGTH_SHORT).show();
                                                holder.btnSendRequest.setVisibility(View.GONE);
                                                holder.pbRequest.setVisibility(View.GONE);
                                                holder.btnCancelRequest.setVisibility(View.VISIBLE);

                                            }
                                        }
                                    });

                        } else{
                            Toast.makeText(context,
                                    context.getString(R.string.failed_to_cancel_reqeust,
                                            task.getException()),
                                    Toast.LENGTH_SHORT).show();
                            holder.btnSendRequest.setVisibility(View.GONE);
                            holder.pbRequest.setVisibility(View.GONE);
                            holder.btnCancelRequest.setVisibility(View.VISIBLE);

                        }
                    }
                });
            }
        });
    }

    @Override
    public int getItemCount() {
        return findFriendModelList.size();
    }

    public class FindFriendViewHolder extends  RecyclerView.ViewHolder {
        private ImageView ivProfile;
        private TextView tvFullName;
        private Button btnSendRequest, btnCancelRequest;
        private ProgressBar pbRequest;

        public FindFriendViewHolder(@NonNull View itemView) {
            super(itemView);
            ivProfile        = itemView.findViewById(R.id.ivProfile);
            tvFullName       = itemView.findViewById(R.id.tvFullName);
            btnSendRequest   = itemView.findViewById(R.id.btnSendRequest);
            btnCancelRequest = itemView.findViewById(R.id.btnCancelRequest);
            pbRequest        = itemView.findViewById(R.id.pbRequest);


        }
    }
}
