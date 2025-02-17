package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.example.slotbook.R

class DashboardActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dashboard)

        findViewById<Button>(R.id.btnManageTracks).setOnClickListener {
            startActivity(Intent(this, TechTrackActivity::class.java))
        }
        findViewById<Button>(R.id.btnBookedSlots).setOnClickListener {
            startActivity(Intent(this, BookedSlotsActivity::class.java))
        }
        findViewById<Button>(R.id.btnLogout).setOnClickListener {
            startActivity(Intent(this, LoginActivity::class.java))
        }
    }
}
