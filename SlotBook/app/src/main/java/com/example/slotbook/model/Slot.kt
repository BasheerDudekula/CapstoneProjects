package com.example.slotbook.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "slots")
data class Slot(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val trackId: Int = 0,
    val date: String = "",
    val time: String = "",
    val interviewer: String = "",
    val isBooked: Boolean = false
)
