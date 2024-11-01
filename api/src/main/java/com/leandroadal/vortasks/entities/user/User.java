package com.leandroadal.vortasks.entities.user;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.shop.product.Product;
import com.leandroadal.vortasks.entities.social.friend.FriendInvite;
import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
	private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Enumerated(EnumType.STRING)
    private UserRole role;

	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private ProgressData progressData; // Referência ao usuário associado

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Backup backup; // Referência ao backup associado

    @JoinTable(
      name = "user_purchased_products", 
      joinColumns = @JoinColumn(name = "user_id"), 
      inverseJoinColumns = @JoinColumn(name = "product_id"))
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)  
    private List<Product> purchasedProducts = new ArrayList<>();

    @OneToMany(mappedBy = "id.senderUser")
    private Set<FriendInvite> senderFriendRequests = new HashSet<>();

    @OneToMany(mappedBy = "id.receiverUser")
    private Set<FriendInvite> receivedFriendRequests = new HashSet<>();

    @ManyToMany(mappedBy = "users", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Friendship> friendships = new HashSet<>();

    @ManyToMany(mappedBy = "participants", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<GroupTask> groupTasks = new ArrayList<>();


    public User(String name, String username, String email, String password) {
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
    }

}
