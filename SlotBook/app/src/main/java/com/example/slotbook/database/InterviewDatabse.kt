package com.example.slotbook.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.example.slotbook.dao.BookedSlotDao
import com.example.slotbook.dao.SlotDao
import com.example.slotbook.dao.TechTrackDao
import com.example.slotbook.dao.UserDao
import com.example.slotbook.model.BookedSlot
import com.example.slotbook.model.Slot
import com.example.slotbook.model.TechTrack
import com.example.slotbook.model.User

@Database(entities = [User::class, TechTrack::class, Slot::class, BookedSlot::class], version = 1)
abstract class InterviewDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun techTrackDao(): TechTrackDao
    abstract fun slotDao(): SlotDao
    abstract fun bookedSlotDao(): BookedSlotDao

    companion object {
        @Volatile
        private var INSTANCE: InterviewDatabase? = null

        fun getDatabase(context: Context): InterviewDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    InterviewDatabase::class.java,
                    "interview_database"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}
