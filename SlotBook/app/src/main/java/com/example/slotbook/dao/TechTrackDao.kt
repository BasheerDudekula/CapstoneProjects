package com.example.slotbook.dao

import androidx.room.Dao
import androidx.room.Query
import com.example.slotbook.model.TechTrack

@Dao
interface TechTrackDao {

    @Query("SELECT * FROM tech_tracks")
    suspend fun getTracks(): List<TechTrack>

    suspend fun getHardcodedTracks(): List<TechTrack> {
        return listOf(
            TechTrack(1, "Android Development"),
            TechTrack(2, "iOS Development"),
            TechTrack(3, "Web Development"),
            TechTrack(4, "Java Full Stack Developer"),
            TechTrack(5,"Frond End Development")
        )
    }
}

