package com.example.slotbook.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import com.example.slotbook.model.BookedSlot

@Dao
interface BookedSlotDao {
    @Insert
    suspend fun bookSlot(bookedSlot: BookedSlot)

    @Query("SELECT * FROM booked_slots")
    suspend fun getAllBookedSlots(): List<BookedSlot>

    @Delete
    suspend fun releaseSlot(bookedSlot: BookedSlot)
}
