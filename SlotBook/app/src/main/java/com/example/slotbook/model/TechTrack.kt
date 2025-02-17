package com.example.slotbook.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "tech_tracks")
data class TechTrack(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val name: String
)
