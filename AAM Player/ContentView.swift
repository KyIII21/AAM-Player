//
//  ContentView.swift
//  AAM Player
//
//  Created by Дмитрий on 06.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import AVKit

public struct PlaylistForPlayer{
    struct QueuePlaylist{
        var id: UUID
        var sound: String
        var pause: Int16
        init(){
            id = UUID()
            sound = ""
            pause = 0
        }
    }
    var playlistName: String
    var queue: [QueuePlaylist]
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Attr.entity(), sortDescriptors: []) var attrs: FetchedResults<Attr>
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>
    @FetchRequest(entity: Playlist.entity(), sortDescriptors: []) var playlists: FetchedResults<Playlist>
    
    @ObservedObject var myPlayer = AudioPlayer()
//    @State var currentItem: Item?
//    var nextItem: Item?{
//        if let curItem = currentItem{
//            if let curIndex = items.firstIndex(of: curItem){
//                if curIndex < items.count - 1 {
//                   return items[curIndex + 1]
//                }
//            }
//
//        }
//        return nil
//    }
//    var playlistArray: [Playlist] {
//            let set = playlists as? Set<Playlist> ?? []
//            return set.filter{$0.items != nil}
//        }
    
    func deletePlaylists(at offsets: IndexSet) {
        for index in offsets {
            let playlist = playlists[index]
            moc.delete(playlist)
        }
        do {
            if self.moc.hasChanges {
                try self.moc.save()
            }
        } catch {
            // handle the Core Data error
            fatalError("Save in Core Data error. (After Deleted Elements)")
        }
    }
    
    func playingThisUrl(item: Item) -> Bool{
        if myPlayer.getStatusPlayer() != .play{
            return false
        }
        if myPlayer.getCurrentItemID() == item.id{
            return true
        }
        return false
    }
    
//    func nextSoundToPlay(){
//        if self.myPlayer.playerFinidhed{
//            if let next = self.nextItem{
//                self.myPlayer.initPlayer(itemId: playlists)
//                self.myPlayer.play()
//                self.currentItem = next
//                self.currentItem!.playing = true
//                self.myPlayer.playerFinidhed = false
//            }
//        }
//
//    }

    var body: some View {
        //AudioView()
        
        VStack {
            Button("Add"){
                self.addPlaylist()
            }
            List{
                ForEach(playlists, id: \.self){ playlist in
                    VStack{
                        HStack{
                            Text(playlist.wrappedName)
                            Text("(\(playlist.itemsArray.count))")
                        }
                        ForEach(playlist.itemsArray, id: \.self){ item in
                            VStack{
                                HStack{
                                    Text(item.wrappedName)
                                    Button(action: {
                                        if self.playingThisUrl(item: item) {
                                            self.myPlayer.pause()
                                            //item.playing = false
                                        }else{
                                            var myPlaylist: PlaylistForPlayer = playlist.playlistForPlayer
                                            //myPlaylist.queue = myPlaylist.queue.remove(at: myPlaylist.queue.firstIndex(where: {$0.id == item.id}))
                                            print(myPlaylist)
                                            while(myPlaylist.queue.first?.id != item.id){
                                                myPlaylist.queue.removeFirst()
                                            }
                                            print(myPlaylist)
//                                            for mpl in myPlaylist.queue{
//                                                if mpl.id != item.id{
//                                                    myPlaylist.queue.removeFirst()
//                                                }else{
//                                                    break
//                                                }
//                                            }
                                            self.myPlayer.initPlayer(itemId: myPlaylist)
                                            self.myPlayer.play()
                                            //item.playing = true
                                            //self.currentItem = item
                                            
                                        }
                                    }) {
                                        Image(systemName: self.playingThisUrl(item: item) ? "pause.circle.fill" : "play.circle.fill").resizable()
                                            .frame(width: 35, height: 35)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.black)
                                    }
                                }
                                    
                                Text(item.displayAttr.wrappedText)
                            }
                        }

                    }
                }
                .onDelete(perform: deletePlaylists)
                .buttonStyle(BorderlessButtonStyle())
            }
            
            
            
            
        }
    }
    func addPlaylist(){
        let attr1 = Attr(context: self.moc)
        attr1.key = "en"
        attr1.text = "Text1"
        attr1.sound = "https://banner-phrases-bucket.s3-us-west-1.amazonaws.com/flow-sample-sounds/d33daab1-2257-42b9-87c0-8c47f3552764.mp3"
        attr1.display = true
       
        let attr2 = Attr(context: self.moc)
        attr2.key = "ru"
        attr2.text = "Text2"
        attr2.sound = "https://banner-phrases-bucket.s3-us-west-1.amazonaws.com/flow-sample-sounds/6161f533-b527-4eb3-aff1-75c7f3c4a357.mp3"
        attr2.display = false

        let item1 = Item(context: self.moc)
        item1.name = "AName1"
        item1.id = UUID()
        item1.addToAttrs(attr1)
        item1.addToAttrs(attr2)

        let attr3 = Attr(context: self.moc)
        attr3.key = "en"
        attr3.text = "Text3"
        attr3.sound = "https://banner-phrases-bucket.s3-us-west-1.amazonaws.com/flow-sample-sounds/d33daab1-2257-42b9-87c0-8c47f3552764.mp3"
        attr3.display = true

        let attr4 = Attr(context: self.moc)
        attr4.key = "ru"
        attr4.text = "Text4"
        attr4.sound = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"
        attr4.display = false

        let item2 = Item(context: self.moc)
        item2.name = "AName2"
        item2.id = UUID()
        item2.addToAttrs(attr3)
        item2.addToAttrs(attr4)

        let attr5 = Attr(context: self.moc)
        attr5.key = "en"
        attr5.text = "Text5"
        attr5.sound = "https://banner-phrases-bucket.s3-us-west-1.amazonaws.com/flow-sample-sounds/fdfe2ff4-ff58-49cf-85af-24f0161bac2b.mp3"
        attr5.display = true
        
        let attr6 = Attr(context: self.moc)
        attr6.key = "ru"
        attr6.text = "Text5"
        attr6.sound = "https://banner-phrases-bucket.s3-us-west-1.amazonaws.com/flow-sample-sounds/fdfe2ff4-ff58-49cf-85af-24f0161bac2b.mp3"
        attr6.display = false



        let item3 = Item(context: self.moc)
        item3.name = "AName3"
        item3.id = UUID()
        item3.addToAttrs(attr5)
        item3.addToAttrs(attr6)


        let keyPause = KeyPause(context: self.moc)
        keyPause.key = "en"
        keyPause.pause = 3
        let keyPause3 = KeyPause(context: self.moc)
        keyPause3.key = "en"
        keyPause3.pause = 4
        let keyPause2 = KeyPause(context: self.moc)
        keyPause2.key = "ru"
        keyPause2.pause = 2

        let playlist = Playlist(context: self.moc)
        playlist.name = "Playlist 1"

        playlist.addToOrder(keyPause)
        playlist.addToOrder(keyPause3)
        playlist.addToOrder(keyPause2)

        playlist.addToItems(item1)
        playlist.addToItems(item2)
        playlist.addToItems(item3)

        if self.moc.hasChanges {
           try? self.moc.save()
        }
    }
}

//struct ContentView: View {
//    
//    @State var audioPlayer: AVAudioPlayer!
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                self.audioPlayer.play()
//            }) {
//                Image(systemName: "play.circle.fill").resizable()
//                    .frame(width: 65, height: 65)
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.white)
//            }
//        }
//        .onAppear {
//            
//            let sound = Bundle.main.path(forResource: "song", ofType: "mp3")
//            
//            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//            
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
