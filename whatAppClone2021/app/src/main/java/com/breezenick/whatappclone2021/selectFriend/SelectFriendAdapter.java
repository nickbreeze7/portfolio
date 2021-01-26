package com.breezenick.whatappclone2021.selectFriend;


import android.content.Context;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.breezenick.whatappclone2021.R;
import com.breezenick.whatappclone2021.common.Constants;
import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.util.List;

public class SelectFriendAdapter extends RecyclerView.Adapter<SelectFriendAdapter.SelectFriendViewHolder>{
    private Context context;
    private List<SelectFriendModel> friendModelList;

    public SelectFriendAdapter(Context context, List<SelectFriendModel> friendModelList) {
        this.context = context;
        this.friendModelList = friendModelList;
    }

    @NonNull
    @Override
    public SelectFriendViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view =
                LayoutInflater.from(context).inflate(R.layout.select_friend_layout, parent, false);

        return new SelectFriendViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull final SelectFriendViewHolder holder, int position) {
        final SelectFriendModel friendModel =
                friendModelList.get(position);
        holder.tvFullName.setText(friendModel.getUserName());

        StorageReference photRef =
                FirebaseStorage.getInstance().getReference().child(Constants.IMAGES_FOLDER+"/"+ friendModel.getPhotoName());
        photRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(Uri uri) {
                Glide.with(context)
                        .load(uri)
                        .placeholder(R.drawable.default_profile)
                        .error(R.drawable.default_profile)
                        .into(holder.ivProfile);
            }
        });
        holder.llSelectFriend.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                if(context instanceof  SelectFriendActivity){
                    ((SelectFriendActivity)context).returnSelectedFriend(
                            friendModel.getUserId(), friendModel.getUserName(),
                            friendModel.getUserId()+".jpg");
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return friendModelList.size();
    }

    public class SelectFriendViewHolder extends RecyclerView.ViewHolder {
        private LinearLayout llSelectFriend;
        private ImageView ivProfile;
        private TextView tvFullName;

        public SelectFriendViewHolder(@NonNull View itemView) {
            super(itemView);

            llSelectFriend = itemView.findViewById(R.id.llSelectFriend);
            ivProfile = itemView.findViewById(R.id.ivProfile);
            tvFullName = itemView.findViewById(R.id.tvFullName);

        }
    }
}
