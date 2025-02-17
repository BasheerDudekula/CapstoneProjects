package com.example.slotbook.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "booked_slots")
data class BookedSlot(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val slotId: Int,
    val bookedBy: Int,
    val slotTime: String,
    val interviewerName: String
)
