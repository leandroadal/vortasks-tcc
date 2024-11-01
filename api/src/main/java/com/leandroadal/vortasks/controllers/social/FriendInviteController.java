package com.leandroadal.vortasks.controllers.social;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.leandroadal.vortasks.controllers.social.doc.FriendInviteDocSwagger;
import com.leandroadal.vortasks.entities.social.friend.FriendInvite;
import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendInviteResponseDTO;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendshipDTO;
import com.leandroadal.vortasks.entities.social.friend.dto.create.FriendInviteRequestDTO;
import com.leandroadal.vortasks.services.social.friendship.FriendInviteService;

import jakarta.validation.Valid;

@RestController
@RequestMapping(value = "/social/friends/invite")
public class FriendInviteController {

    @Autowired
    private FriendInviteService service;

    @GetMapping("/{senderId}/{receiverId}")
    @FriendInviteDocSwagger.GetFriendInviteSwagger
    public ResponseEntity<FriendInviteResponseDTO> getFriendInvite(@PathVariable String senderId, @PathVariable String receiverId) {
        FriendInvite friendInvite = service.getFriendInviteByUsersId(senderId, receiverId);
        return ResponseEntity.ok(new FriendInviteResponseDTO(friendInvite));
    }

    @GetMapping
    @FriendInviteDocSwagger.GetMyFriendInviteSwagger
    public ResponseEntity<List<FriendInviteResponseDTO>> getMyFriendInvite() {
        List<FriendInvite> friendship = service.friendInvitesForUser();
        return ResponseEntity.ok(friendship.stream().map(FriendInviteResponseDTO::new).toList());
    }

    @PostMapping("/{senderId}/{receiverUsername}")
    @FriendInviteDocSwagger.SendFriendRequestSwagger
    public ResponseEntity<FriendInviteResponseDTO> sendFriendRequest(@PathVariable String senderId, @PathVariable String receiverUsername) {
        FriendInvite friendInvite = service.sendFriendRequest(senderId, receiverUsername);

        return ResponseEntity.ok(new FriendInviteResponseDTO(friendInvite));
    }

    @PostMapping("/accept/{senderId}/{receiverId}")
    @FriendInviteDocSwagger.AcceptFriendRequestSwagger
    public ResponseEntity<FriendshipDTO> acceptFriendRequest(@PathVariable String senderId, @PathVariable String receiverId) {
        Friendship friendInvite = service.acceptFriendRequest(senderId, receiverId);

        return ResponseEntity.ok(new FriendshipDTO(friendInvite));
    }

    @PutMapping("/refuse/{senderId}/{receiverId}")
    @FriendInviteDocSwagger.RefusedFriendInviteSwagger
    public ResponseEntity<String> refusedFriendInvite(@PathVariable String senderId, @PathVariable String receiverId, @RequestBody FriendInviteRequestDTO request) {
        service.refusedFriendInvite(senderId, receiverId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/cancel/{senderId}/{receiverId}")
    @FriendInviteDocSwagger.CancelFriendInviteSwagger
    public ResponseEntity<String> cancelFriendInvite(@PathVariable String senderId, @PathVariable String receiverId, @Valid @RequestBody FriendInviteRequestDTO request) {
        service.cancelFriendInvite(senderId, receiverId);
        return ResponseEntity.noContent().build();
    }

}
