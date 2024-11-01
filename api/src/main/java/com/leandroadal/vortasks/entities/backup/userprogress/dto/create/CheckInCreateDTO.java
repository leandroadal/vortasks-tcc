package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import java.time.Instant;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.CheckIn;

public record CheckInCreateDTO(
    int countCheckInDays, 
    int month, 
    int year, 
    Instant lastCheckInDate) {

    public CheckIn toCheckIn(Backup backup) {
        CheckIn checkIn = new CheckIn();
        checkIn.setCountCheckInDays(countCheckInDays);
        checkIn.setMonth(month);
        checkIn.setYear(year);
        checkIn.setLastCheckInDate(lastCheckInDate);
        checkIn.setBackup(backup);
        return checkIn;
    }
}
