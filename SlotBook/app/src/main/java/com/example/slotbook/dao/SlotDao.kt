package com.example.slotbook.dao

import androidx.room.Dao
import androidx.room.Query
import com.example.slotbook.model.Slot

@Dao
interface SlotDao {
    @Query("SELECT * FROM slots WHERE trackId = :trackId AND isBooked = 0")
    suspend fun getAvailableSlots(trackId: Int): List<Slot>

    suspend fun getHardcodedSlots(trackId: Int): List<Slot> {
        return when (trackId) {
            1 -> listOf(
                Slot(id = 1, trackId = 1, date = "2025-02-16", time = "10:00 AM", interviewer = "Interviewer A", isBooked = false),
                Slot(id = 2, trackId = 1, date = "2025-02-16", time = "11:00 AM", interviewer = "Interviewer B", isBooked = false)
            )
            2 -> listOf(
                Slot(id = 3, trackId = 2, date = "2025-02-17", time = "02:00 PM", interviewer = "Interviewer C", isBooked = false),
                Slot(id = 4, trackId = 2, date = "2025-02-17", time = "03:00 PM", interviewer = "Interviewer D", isBooked = false)
            )
            3 -> listOf(
                Slot(id = 5, trackId = 3, date = "2025-02-18", time = "05:00 PM", interviewer = "Interviewer E", isBooked = false),
                Slot(id = 6, trackId = 3, date = "2025-02-18", time = "06:00 PM", interviewer = "Interviewer F", isBooked = false)
            )
            4 -> listOf(
                Slot(id = 7, trackId = 4, date = "2025-02-19", time = "012:00 PM", interviewer = "Interviewer G", isBooked = false),
                Slot(id = 8, trackId = 4, date = "2025-02-19", time = "01:00 PM", interviewer = "Interviewer H", isBooked = false)
            )
            else -> emptyList()
        }
    }
}

