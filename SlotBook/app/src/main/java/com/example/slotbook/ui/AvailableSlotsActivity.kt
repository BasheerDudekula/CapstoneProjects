package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.adapter.AvailableSlotsAdapter
import com.example.slotbook.database.InterviewDatabase
import kotlinx.coroutines.launch

class AvailableSlotsActivity : AppCompatActivity() {
    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: AvailableSlotsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_available_slots)

        val trackId = intent.getIntExtra("trackId", -1)

        recyclerView = findViewById(R.id.recyclerViewSlots)
        recyclerView.layoutManager = LinearLayoutManager(this)

        // Fetching slots inside coroutine
        lifecycleScope.launch {
            val slots = InterviewDatabase.getDatabase(this@AvailableSlotsActivity)
                .slotDao().getHardcodedSlots(trackId)

            adapter = AvailableSlotsAdapter(slots) { slot ->
                val intent = Intent(this@AvailableSlotsActivity, BookSlotActivity::class.java).apply {
                    putExtra("slotId", slot.id)
                    putExtra("slotTime", slot.time)
                    putExtra("interviewerName", slot.interviewer)
                }
                startActivity(intent)
            }
            recyclerView.adapter = adapter
        }

        findViewById<Button>(R.id.btnDashboard).setOnClickListener {
            startActivity(Intent(this, DashboardActivity::class.java))
        }
        findViewById<Button>(R.id.btnTechTracks).setOnClickListener {
            startActivity(Intent(this, TechTrackActivity::class.java))
        }
    }
}