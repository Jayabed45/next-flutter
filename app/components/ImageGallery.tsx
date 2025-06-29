'use client'

import { useState } from 'react'

interface Image {
  _id: string
  filename: string
  originalName: string
  path: string
  size: number
  uploadDate: string
  description: string
}

interface ImageGalleryProps {
  images: Image[]
  onImageDelete: (imageId: string) => void
}

export default function ImageGallery({ images, onImageDelete }: ImageGalleryProps) {
  const [deletingId, setDeletingId] = useState<string | null>(null)

  const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api'

  const handleDelete = async (imageId: string) => {
    if (!confirm('Are you sure you want to delete this image?')) {
      return
    }

    setDeletingId(imageId)

    try {
      const response = await fetch(`${API_URL}/images/${imageId}`, {
        method: 'DELETE',
      })

      if (!response.ok) {
        throw new Error('Delete failed')
      }

      onImageDelete(imageId)
    } catch (error) {
      console.error('Delete error:', error)
      alert('Failed to delete image. Please try again.')
    } finally {
      setDeletingId(null)
    }
  }

  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes'
    const k = 1024
    const sizes = ['Bytes', 'KB', 'MB', 'GB']
    const i = Math.floor(Math.log(bytes) / Math.log(k))
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })
  }

  if (images.length === 0) {
    return (
      <div className="text-center py-8">
        <p className="text-gray-500">No images uploaded yet.</p>
      </div>
    )
  }

  return (
    <div className="space-y-4 max-h-96 overflow-y-auto">
      {images.map((image) => (
        <div key={image._id} className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
          <div className="flex items-start space-x-4">
            <div className="flex-shrink-0">
              <img
                src={`${API_URL.replace('/api', '')}/${image.path}`}
                alt={image.originalName}
                className="w-20 h-20 object-cover rounded-lg"
              />
            </div>
            
            <div className="flex-1 min-w-0">
              <h3 className="text-sm font-medium text-gray-900 truncate">
                {image.originalName}
              </h3>
              {image.description && (
                <p className="text-sm text-gray-500 mt-1">
                  {image.description}
                </p>
              )}
              <div className="flex items-center space-x-4 mt-2 text-xs text-gray-500">
                <span>{formatFileSize(image.size)}</span>
                <span>{formatDate(image.uploadDate)}</span>
              </div>
            </div>
            
            <button
              onClick={() => handleDelete(image._id)}
              disabled={deletingId === image._id}
              className="flex-shrink-0 bg-red-600 text-white px-3 py-1 rounded-md text-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {deletingId === image._id ? 'Deleting...' : 'Delete'}
            </button>
          </div>
        </div>
      ))}
    </div>
  )
} 