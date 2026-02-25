package com.example.taskmanager.user;

import jakarta.persistence.*;
import org.hibernate.annotations.UuidGenerator;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.UUID;

@Entity
@Table(name = "app_user")
public class AppUser {

    @Id
    @GeneratedValue
    @UuidGenerator
    @Column(columnDefinition ="uuid")
    private UUID id;

    @Column(nullable = false, unique = true, columnDefinition = "text")
    private String email;

    @Column(name = "password_hash", nullable = false, columnDefinition = "text")
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, columnDefinition = "text")
    private Role role = Role.USER;

    @Column(name = "created_at", nullable = false, columnDefinition = "timestampz")
    private OffsetDateTime createdAt;
    
    @PrePersist
    void prePersist() {
        if (createdAt == null) createdAt = OffsetDateTime.now(ZoneOffset.UTC);
        if (email != null) email = email.trim().toLowerCase();
    }

    public UUID getId() { return id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public OffsetDateTime getCreatedAt() { return createdAt; }

}