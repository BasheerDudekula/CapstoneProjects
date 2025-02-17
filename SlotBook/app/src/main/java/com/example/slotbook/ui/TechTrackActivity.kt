package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.adapter.TechTrackAdapter
import com.example.slotbook.database.InterviewDatabase
import kotlinx.coroutines.launch

class TechTrackActivity : AppCompatActivity() {
    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: TechTrackAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_tech_track)

        recyclerView = findViewById(R.id.recyclerViewTechTracks)
        recyclerView.layoutManager = LinearLayoutManager(this)

        // Launching coroutine
        lifecycleScope.launch {
            val tracks = InterviewDatabase.getDatabase(this@TechTrackActivity).techTrackDao().getHardcodedTracks()
            adapter = TechTrackAdapter(tracks) { track ->
                val intent = Intent(this@TechTrackActivity, AvailableSlotsActivity::class.java)
                intent.putExtra("trackId", track.id)
                startActivity(intent)
            }
            recyclerView.adapter = adapter
        }
        findViewById<Button>(R.id.btnDashboard).setOnClickListener {
            startActivity(Intent(this, DashboardActivity::class.java))
        }
    }
}
