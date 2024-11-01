package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import java.time.Instant;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.CheckIn;

public record CheckInDTO(
    String id, 
    int countCheckInDays, 
    int month, 
    int year, 
    Instant lastCheckInDate) {

    public CheckInDTO(CheckIn checkIn) {
        this(
            checkIn.getId(),
            checkIn.getCountCheckInDays(),
            checkIn.getMonth(),
            checkIn.getYear(),
            checkIn.getLastCheckInDate()
        );
    }

    public CheckIn toCheckIn(Backup backup) {
        return new CheckIn(
            id,
            countCheckInDays,
            month,
            year,
            lastCheckInDate,
            backup
        );
    }
}
