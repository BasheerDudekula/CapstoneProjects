package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.adapter.BookedSlotsAdapter
import com.example.slotbook.database.InterviewDatabase
import com.example.slotbook.helper.NotificationHelper
import com.example.slotbook.model.BookedSlot
import kotlinx.coroutines.launch

class BookedSlotsActivity : AppCompatActivity() {
    private lateinit var database: InterviewDatabase
    private lateinit var notificationHelper: NotificationHelper
    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: BookedSlotsAdapter
    private var bookedSlots: List<BookedSlot> = emptyList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_booked_slots)

        database = InterviewDatabase.getDatabase(this)
        notificationHelper = NotificationHelper(this)
        recyclerView = findViewById(R.id.recyclerViewBookedSlots)
        recyclerView.layoutManager = LinearLayoutManager(this)

        fetchBookedSlots()
        
        findViewById<Button>(R.id.btnDashboard).setOnClickListener {
            startActivity(Intent(this, DashboardActivity::class.java))
        }
    }

    private fun fetchBookedSlots() {
        lifecycleScope.launch {
            bookedSlots = database.bookedSlotDao().getAllBookedSlots()
            runOnUiThread {
                adapter = BookedSlotsAdapter(bookedSlots) { bookedSlot ->
                    releaseSlot(bookedSlot)
                }
                recyclerView.adapter = adapter
            }
        }
    }

    private fun releaseSlot(bookedSlot: BookedSlot) {
        lifecycleScope.launch {
            database.bookedSlotDao().releaseSlot(bookedSlot)
            notificationHelper.sendEmailNotification(
                "Slot Released",
                "Your booked interview slot with ${bookedSlot.interviewerName} at ${bookedSlot.slotTime} has been released."
            )
            runOnUiThread {
                Toast.makeText(this@BookedSlotsActivity, "Slot Released", Toast.LENGTH_SHORT).show()
                fetchBookedSlots()
            }
        }
    }

}
