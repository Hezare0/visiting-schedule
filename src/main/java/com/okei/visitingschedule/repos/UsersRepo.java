package com.okei.visitingschedule.repos;

import com.okei.visitingschedule.entity.Role;
import com.okei.visitingschedule.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UsersRepo extends JpaRepository<User,Long> {
        Optional<User> findByUsername(String username);
        List<User> findUsersByRoles(Role role);
}
