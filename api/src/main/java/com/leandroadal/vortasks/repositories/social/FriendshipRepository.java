package com.leandroadal.vortasks.repositories.social;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.user.User;

import java.util.List;

public interface FriendshipRepository extends JpaRepository<Friendship, String> {

    @Query("SELECT f FROM Friendship f JOIN f.users u WHERE :user MEMBER OF f.users")
    List<Friendship> findFriendshipsByUser(@Param("user") User user);
}
