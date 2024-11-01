package com.leandroadal.vortasks.entities.user;

import java.time.Instant;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "progress_data")
@NoArgsConstructor
@AllArgsConstructor
public class ProgressData {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    private Integer coins;
    private Integer gems;
    private Integer level;
    private Float xp;
    private Instant lastModified;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

}
