package com.example.slotbook.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.model.TechTrack

class TechTrackAdapter(
    private val tracks: List<TechTrack>,
    private val onTrackClick: (TechTrack) -> Unit
) : RecyclerView.Adapter<TechTrackAdapter.TechTrackViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TechTrackViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_tech_track, parent, false)
        return TechTrackViewHolder(view)
    }

    override fun onBindViewHolder(holder: TechTrackViewHolder, position: Int) {
        val track = tracks[position]
        holder.bind(track)
    }

    override fun getItemCount(): Int {
        return tracks.size
    }

    inner class TechTrackViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val trackName: TextView = itemView.findViewById(R.id.textViewTrackName)

        fun bind(track: TechTrack) {
            trackName.text = track.name
            itemView.setOnClickListener {
                onTrackClick(track)
            }
        }
    }
}